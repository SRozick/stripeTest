require 'rspec-html-matchers'

RSpec.describe "this page" do

  before (:each) do
    visit this_path
  end #before

  let(:meta_description) { "Meta description for this page"}

  it_behaves_like "a page that is SEO-compliant"
  it_behaves_like "a page with a standard footer"

end #this page
