require 'rails_helper'

RSpec.describe StaticController, :type => :controller do

  describe "GET home" do
    it "renders the page with the home template" do
      get :home
      # expect(response).to have_http_status(:success)
      expect(response).to render_template(:home)
    end
  end

  describe "GET about" do
    it "renders the page with the about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

end
