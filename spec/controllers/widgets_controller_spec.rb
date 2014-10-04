require 'spec_helper'

RSpec.describe WidgetsController do
  describe "GET #index" do

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
      widget = FactoryGirl.create(:widget)
      other_widget = FactoryGirl.create(:widget)
      get :index
      expect(assigns(:widgets)).to include(widget)
    end #case populates widgets

    it "renders the :index view" do
      get :index
      expect(response).to render_template("index")
    end #case renders :index
  end #GET #index

  describe "GET #show" do
    context "when the widget exists" do
      widget = FactoryGirl.create(:widget)
      it "assigns the requested widget to @widget" do

        get :show, id: widget
        expect(assigns(:widget)).to eq(widget)
      end #case assigns
      it "renders the :show template"
    end #context widget exists

    context "when the widget does not exist" do
      it "renders the :index template"
    end #context widget not exist
  end #GET #show

  describe "GET #new" do
    it "assigns a new widget to @widget"
    it "renders the :new template"
  end #GET #new

  describe "GET #edit" do
    context "with valid attributes" do
      it "assigns the requested widget to @widget"
      it "renders the :edit template"
    end #with valid attributes

    context "with invalid attributes" do
      it "does not assign a widget to @widget"
      it "renders the :index view"
    end #with invalid attributes
  end #GET #edit

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new widget"
      it "redirects to the index page"
    end #with valid attributes

    context "with invalid attributes" do
      it "does not save the new widget"
      it "re-renders the :new template"
    end #with invalid attributes
  end #POST #create

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

  describe "DELETE #destroy" do
    it "removes the widget from the database"
    it "redirects to the :index view"
  end #DELETE #destroy

end #WidgetsController
