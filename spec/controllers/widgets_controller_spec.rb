require 'spec_helper'

RSpec.describe WidgetsController do
# ANNOTATE: Each `describe` block represents a class (completed by rspec), so the use of `@instance` variables within the `describe` blocks is appropriate.  See
# http://stackoverflow.com/questions/12645198/how-do-instance-variables-in-rspec-work

#TODO: Invalid attributes cases should be tested for flash messages
#TODO: Valid create/ edit cases should be tested for flash messages

  #######################################################
  describe "GET #index" do
    let(:widget)        { FactoryGirl.create(:widget) }
    let(:other_widget)  { FactoryGirl.create(:widget) }

    before(:each) do
      get :index
    end #before

    #TODO: Why not Widget.create or simply create
    #TODO: Why isn't database clearing after each test iteration?

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

    context "when the widget exists" do
      let(:widget) { FactoryGirl.create(:widget) }

      before(:each) do
        get :show, id: widget
      end

      it "assigns the requested widget to @widget" do
        expect(assigns(:widget)).to eq(widget)
      end #case assigns

      it "renders the :show template" do
        expect(response).to render_template("show")
      end #case renders

    end #context widget exists

    context "when the widget does not exist" do
      let(:wrong_id) { Widget.maximum(:id).next }

      before(:each) do
        get :show, id: wrong_id
      end #before

      it "renders the :index template" do
        expect(response).to redirect_to( :action => "index")
      end #case renders :index

    end #context widget not exist
  end #GET #show

  ########################################################
  describe "GET #new" do

    before (:each) do
      get :new
    end #before

    it "assigns a new widget to @widget" do
      expect(assigns(:widget)).to be_a_new(Widget)
    end #case assigns new widget

    it "renders the :new template" do
      expect(response).to render_template("new")
    end #case renders :new

  end #GET #new

  #########################################################
  describe "GET #edit" do

    context "when the widget exists" do
      let(:widget) { FactoryGirl.create(:widget) }

      before(:each) do
        get :edit, id: widget
      end #before

      it "assigns the requested widget to @widget" do
        expect(assigns(:widget)).to eq(widget)
      end #case assigns


      it "renders the :edit template" do
        expect(response).to render_template("edit")
      end #case render edit

    end #with valid attributes

    context "when the widget does not exist" do
      let(:wrong_id) { Widget.maximum(:id).next }

      before(:each) do
        get :edit, id: wrong_id
      end #before

      it "renders the :index view" do
        wrong_id = Widget.maximum(:id).next
        get :edit, id: wrong_id
        expect(response).to redirect_to( :action => "index")
      end #case renders :index

    end #with invalid attributes
  end #GET #edit

  ##########################################################
  describe "POST #create" do
    context "with valid attributes" do
      subject { post :create, :widget => FactoryGirl.attributes_for(:widget) }

      it "creates a new widget" do
        expect{ subject }.to change(Widget, :count).by(1)
      end #case creates widget

      it "redirects to the new widget" do
        expect(subject).to redirect_to  :action => :show,
                                        :id => assigns(:widget).id
      end #case redirect to new widget
    end #with valid attributes

    context "with invalid attributes" do
      subject { post :create, :widget => FactoryGirl.attributes_for(:invalid_widget) }

      it "does not save the new widget" do
        expect{ subject }.not_to change(Widget, :count)
      end #case does not save

      it "re-renders the :new template" do
        expect(subject).to render_template("new")
      end #case renders :new

    end #with invalid attributes
  end #POST #create

  #########################################################
  describe "PATCH #update" do
    context "with valid attributes" do
      it "saves updates to the widget"
      it "does not change other widgets"
      it "renders the :show template"
    end #with valid attributes

    context "with invalid attributes" do
      it "does not change the widget"
      it "redirects to the :edit template for @widget"
    end #with invalid attributes
  end #PATCH #update

  ##########################################################
  describe "DELETE #destroy" do
    it "removes the widget from the database"
    it "redirects to the :index view"
  end #DELETE #destroy

end #WidgetsController
