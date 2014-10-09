require 'spec_helper'
RSpec.describe WidgetsController do

#TODO: Test delete vs invalid object

  #######################################################
  describe "GET #index" do
    let(:widget)                    { create(:widget) }
    let(:other_widget)              { create(:widget) }
    let(:action)                    { get :index }

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

      it "passes a flash message" do
        expect(controller.flash[:error]).to eq('Item id was not valid')
      end

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

      it "passes a flash message" do
        expect(controller.flash[:error]).to eq('Item id was not valid')
      end


    end #with invalid attributes
  end #GET #edit

  ##########################################################
  describe "POST #create" do
    let(:action)                    { post :create, :widget => attributes_for(:widget) }
    let(:invalid_action)            { post :create, :widget => attributes_for(:invalid_widget) }
    context "with valid attributes" do

      it "creates a new widget" do
        expect{ action }.to change(Widget, :count).by(1)
      end #case creates widget

      it "redirects to the new widget" do
        expect(action).to redirect_to  :action => :show,
                                        :id => assigns(:widget).id
      end #case redirect to new widget

      it "provides notice of update" do
        action
        expect(controller.notice).to eq('Widget was successfully created')
      end
    end #with valid attributes

    context "with invalid attributes" do

      it "does not save the new widget" do
        expect{ invalid_action }.not_to change(Widget, :count)
      end #case does not save

      it "re-renders the :new template" do
        expect(invalid_action).to render_template("new")
      end #case renders :new

      it "provides notice of error" do
        invalid_action
        expect(controller.flash[:error]).to eq("Could not create Widget")
      end
    end #with invalid attributes
  end #POST #create

  #########################################################
describe 'PATCH update' do
  # see http://stackoverflow.com/a/24739399/3780876
  let (:setup)                      {
                                      create :widget
                                      @attributes_before_edit = Widget.new
                                      widget.attributes.each_pair do |key, value|
                                        @attributes_before_edit[key] = value
                                      end
                                    }
  let(:widget)                      { create :widget }

  let(:attributes_changed_in_form)  { { "name" => 'Great updated product' } }
  let(:attributes_changed_elsewhere){ { "picture" => nil } } #include any attributes changed by controller
  let(:expected_final_attributes)   { attributes_changed_in_form.merge(attributes_changed_elsewhere) }
  let(:action)                      { patch :update, id: widget.id, widget: attributes_changed_in_form }
  let(:for_the_same_widget)         { expect(widget.reload.id).to eq(widget.id) }
  let(:invalid_update_attributes)   { { name: "" } }
  let(:invalid_action)              { patch :update, id: widget.id, widget: invalid_update_attributes }
  let(:expect_reload_to_eq_final)   { expected_final_attributes.each_pair do |ukey, uvalue|
                                        widget.attributes.each_pair do |key, value|
                                          if key == ukey
                                            expect(widget.reload[key]).to eq(expected_final_attributes[key])
                                          end #if
                                        end #each widget.attributes
                                      end #each expected_final
                                    }
  let(:expect_unchanged_to_be_same) {
                                      @attributes_before_edit.attributes.each_pair do |key, value|
                                        unchanged = true
                                        expected_final_attributes.each_pair do |ukey, uvalue|
                                          # find out if value was changed during update action.
                                          if key == ukey || key == "updated_at"
                                            unchanged = false
                                          end #if
                                        end #expected_final loop
                                        # if value wasn't changed, test against before and after update values
                                        if unchanged == true
                                          if @attributes_before_edit[key].is_a? ActiveSupport::TimeWithZone
                                            expect(widget[:created_at]).to be_within(0.00001).of(widget.reload[:created_at])
                                          else
                                            expect(@attributes_before_edit[key]).to eq(widget.reload[key])
                                          end #test TimeWithZone
                                        end #if
                                      end #@attributes loop
                                    }

  context "with valid attributes" do

    before { setup }

    it "updates the widget with changed values" do
      action
      expect_reload_to_eq_final
    end #case updates widget

    it "does not change unchanged values" do
      action
      expect_unchanged_to_be_same
    end #case does not change unchanged

    it "redirects to the widget :show template" do
      expect(action).to redirect_to(widget)
    end #case redirect to :show

    it "provides notice of update" do
      action
      expect(controller.notice).to eq('Widget was successfully updated')
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
        expect(controller.flash[:error]).to eq("Could not update Widget")
      end

    end #with invalid attributes
  end #PATCH #update

  ##########################################################
  describe "DELETE #destroy" do
    let(:setup)                     { create :widget }
    let(:action)                    { delete :destroy, id: setup.id }
    let(:id_of_widget_not_exist)    { "0" }
    let(:invalid_action)            { get :edit, id: id_of_widget_not_exist }


    context "when the widget exists" do

      before{ setup }

      it "removes the widget from the database" do
        expect{ action }.to change(Widget, :count).by(-1)
      end #case removes widget

      it "redirects to the :index view" do
        expect(action).to redirect_to(:widgets)
      end #case redirect to :index

      it "Flashes notice of Widget destruction" do
        action
        expect(controller.notice).to eq('Widget was successfully destroyed.')
      end #case provide notice

    end #when the widget exists

    context "when the widget does not exist" do

      before { invalid_action }

      it "renders the :index view" do
        expect(response).to redirect_to( :action => "index")
      end #case renders :index

      it "passes a flash message" do
        expect(controller.flash[:error]).to eq('Item id was not valid')
      end

    end #with invalid attributes

  end #DELETE #destroy

end #WidgetsController
