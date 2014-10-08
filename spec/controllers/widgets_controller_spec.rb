require 'spec_helper'
require 'support/assert_records_values_helper'
RSpec.describe WidgetsController do
# ANNOTATE: Each `describe` block represents a class (completed by rspec), so the use of `@instance` variables within the `describe` blocks is appropriate.  See
# http://stackoverflow.com/questions/12645198/how-do-instance-variables-in-rspec-work

#TODO: Invalid attributes cases should be tested for flash messages
#TODO: Valid create/ edit cases should be tested for flash messages
#TODO: Test delete vs invalid object

  #######################################################
  describe "GET #index" do
    let(:widget)        { create(:widget) }
    let(:other_widget)  { create(:widget) }
    let(:action)        { get :index }

    before { action }

    #TODO: Make a blog note about testing index.  Public available examples
    # do not test for retrieval of the entire index- they test for
    # retrieval of the most recent record.
        # describe "GET #index" do
        #   it "returns an index containing all widgets" do
        #     widget = Widget.create
        #     get :index
        #     expect(assigns(:widgets)).to eq([widget])
        #   end
        # end
    # Replace with:
    it "returns an index containing all widgets" do
      expect(assigns(:widgets)).to include(widget)
    end #case populates widgets

    it "renders the :index view" do
      expect(response).to render_template("index")
    end #case renders :index
  end #GET #index

  #########################################################
  describe "GET #show" do
    let(:widget)                      { create(:widget) }
    let(:id_of_widget_not_exist)      { "0" }
    let(:action)                      { get :show, id: widget }
    let(:invalid_action)              { get :show, id: id_of_widget_not_exist }

    context "when the widget exists" do

      before { action }

      it "assigns the requested widget to @widget" do
        expect(assigns(:widget)).to eq(widget)
      end #case assigns

      it "renders the :show template" do
        expect(response).to render_template("show")
      end #case renders
    end #context widget exists

    context "when the widget does not exist" do

      before { invalid_action }

      it "renders the :index template" do
        expect(response).to redirect_to( :action => "index")
      end #case renders :index
    end #context widget not exist
  end #GET #show

  ########################################################
  describe "GET #new" do
    let(:action)                    { get :new }

    before { action }

    it "assigns a new widget to @widget" do
      expect(assigns(:widget)).to be_a_new(Widget)
    end #case assigns new widget

    it "renders the :new template" do
      expect(response).to render_template("new")
    end #case renders :new

  end #GET #new

  #########################################################
  describe "GET #edit" do
    let(:widget)                    { create(:widget) }
    let(:action)                    { get :edit, id: widget }
    let(:id_of_widget_not_exist)    { "0" }
    let(:invalid_action)            { get :edit, id: id_of_widget_not_exist }

    context "when the widget exists" do

      before { action }

      it "assigns the requested widget to @widget" do
        expect(assigns(:widget)).to eq(widget)
      end #case assigns


      it "renders the :edit template" do
        expect(response).to render_template("edit")
      end #case render edit

    end #with valid attributes

    context "when the widget does not exist" do

      before { invalid_action }

      it "renders the :index view" do
        expect(response).to redirect_to( :action => "index")
      end #case renders :index

    end #with invalid attributes
  end #GET #edit

  ##########################################################
  describe "POST #create" do
    let(:action)                { post :create, :widget => FactoryGirl.attributes_for(:widget) }
    let(:invalid_action)        { post :create, :widget => FactoryGirl.attributes_for(:invalid_widget) }
    context "with valid attributes" do

      it "creates a new widget" do
        expect{ action }.to change(Widget, :count).by(1)
      end #case creates widget

      it "redirects to the new widget" do
        expect(action).to redirect_to  :action => :show,
                                        :id => assigns(:widget).id
      end #case redirect to new widget
    end #with valid attributes

    context "with invalid attributes" do

      it "does not save the new widget" do
        expect{ invalid_action }.not_to change(Widget, :count)
      end #case does not save

      it "re-renders the :new template" do
        expect(invalid_action).to render_template("new")
      end #case renders :new

    end #with invalid attributes
  end #POST #create

  #########################################################
describe 'PATCH update' do
  # see http://stackoverflow.com/a/24739399/3780876
  let(:widget)                      { FactoryGirl.create :widget, price: 25 }

  let(:attributes_changed_in_form)  { { "name" => 'Great updated product' } }
  let(:attributes_changed_elsewhere){ { nil => nil } } #include any attributes changed by controller
  let(:expected_final_attributes)   { attributes_changed_in_form.merge(attributes_changed_elsewhere) }
  let(:action)                      { patch :update, id: widget.id, widget: attributes_changed_in_form }
  let(:for_the_same_widget)         { expect(widget.reload.id).to eq(widget.id) }
  let(:invalid_update_attributes)   { { name: "" } }
  let(:invalid_action)              { patch :update, id: widget.id, widget: invalid_update_attributes }
  let(:expect_reload_to_eq_final)   { expected_final_attributes.each_pair do |ukey, uvalue|
                                        widget.attributes.each_pair do |key, value|
                                          if key == ukey
                                            expect(widget.reload[key]).to eq(expected_final_attributes[ukey])
                                          end #if
                                        end #each widget.attributes
                                      end #each expected_final}
                                    }
  let(:expect_unchanged_to_be_unch) { expected_final_attributes.each_pair do |ukey, uvalue|
                                        widget.attributes.each_pair do |key, value|
                                          if key != ukey
                                            expect(widget.reload[key]).to eq(widget[key])
                                          end #if
                                        end #each widget.attributes
                                      end #each expected_final}
                                    }

  context "with valid attributes" do

    before { action }

    it "updates the widget with changed values" do
      for_the_same_widget
      expect_reload_to_eq_final
    end #case updates widget

    it "does not alter unchanged values" do
      for_the_same_widget
      # TODO: for...each to interate through widget attributes, if not a member of expected_update_attributes, test unchanged
      expect_unchanged_to_be_unch
      expect(widget.reload.price).to eq(widget.price)
    end #case does not alter

    it "redirects to the widget :show template" do
      for_the_same_widget
      expect(response).to redirect_to(widget)
    end #case redirect to :show

    it "provides notice of update" do
      expect(controller.notice).to eq('Widget was successfully updated.')
    end

  end #with valid attributes

    context "with invalid attributes" do

      before { invalid_action }

      it "does not change the widget" do
        for_the_same_widget
        expect(widget).to eq(widget.reload)
      end #case does not change

      it "redirects to the :edit template for @widget" do
        for_the_same_widget
        expect(response).to render_template("edit", id: widget.id)
      end #case redirect to :edit

      it "provides notice of error" do
        expect(controller.flash).not_to be_nil
      end

    end #with invalid attributes
  end #PATCH #update

  ##########################################################
  describe "DELETE #destroy" do
    let(:setup) { FactoryGirl.create :widget }
    let(:action) { delete :destroy, id: setup.id }

    before{ setup }

    it "removes the widget from the database" do
      expect{ action }.to change(Widget, :count).by(-1)
    end #case removes widget

    it "redirects to the :index view" do
      expect(action).to redirect_to(:widgets)
    end #case redirect to :index

    it "provides notice of update" do
      action
      expect(controller.notice).to eq('Widget was successfully destroyed.')
    end #case provide notice

  end #DELETE #destroy

end #WidgetsController
