require 'rspec-html-matchers'

RSpec.describe "the Home page", mobile: true do
  before (:each) do
    visit root_path
  end #before

  let(:resolution) { :mobile }

  let(:meta_description) { "Is your website working for you\\? We specialize in e-commerce, SEO, and mobile design for small business.  Contact us for a free quote to help build your brand!" }

  it_behaves_like "a page that is SEO-compliant"
  it_behaves_like "a page with a standard footer"

  it "uses microdata markup to indicate location"  do
    expect(page).to have_tag('footer') do
      with_tag '.location-info'
    end #test if location-info is in footer
    expect(page).to have_tag('.location-info') do
      with_tag '.company',      with:{ itemprop: 'name'            }
      with_tag '.street',       with:{ itemprop: 'streetAddress'   }
      with_tag '.city',         with:{ itemprop: 'addressLocality' }
      with_tag '.state',        with:{ itemprop: 'addressRegion'   }
    end #have_expect-do
  end #case microdata markup
  # see https://support.google.com/webmasters/answer/176035
  #http://schema.org/
  #https://support.google.com/webmasters/answer/146750

  describe "has a menu bar" do

    it "links to blog, portfolio, services, and contact pages (menu)" do
      expect(page).to have_tag('nav.tab-bar') do
        with_tag '.left-small'
      end #have_tag
    end #case menu

    it "has an accessible left side menu" do
      expect(page).to have_tag('nav.tab-bar') do
        with_tag '.left-small'
      end #have_tag
    end #case left side menu

    it "has an off-canvas left menu" do
      expect(page).to have_tag('nav.left-off-canvas-menu') do
        with_tag 'label',         text: /Inherent Knowledge/
        with_tag 'a',             text: /Home/
        with_tag 'a',             text: /Get a Quote/
        with_tag 'a',             text: /Pricing/
        with_tag 'a',             text: /Blog/
        with_tag 'a',             text: /Services/
        with_tag 'a',             text: /Portfolio/
      end #have_tag
    end #case off-canvas menu

###############################################
    it "goes to the Home page when the Home link is clicked" do
      visit root_path
      page.find('nav.main_nav')
      if resolution == :mobile
        click_link('expose_mobile_nav')
      end #mobile
      page.click_on('Home')
      expect(page).to have_http_status(:success)
      expect(page).to have_content(/hello inherent knowledge/i)
    end #case Home link

    it "links to contact page" do
      expect(page).to have_link("Get a Quote")
    end #case menu

    it "links to pricing page" do
      expect(page).to have_link("Pricing")
    end #case menu

    it "links to blog" do
      expect(page).to have_link("Blog")
    end #case menu

    it "links to services page" do
      expect(page).to have_link("Services")
    end #case menu

    it "links to Portfolio" do
      expect(page).to have_link("Portfolio")
    end #case menu

  end #menu bar

  describe "has main content" do

    it "contains sections about 'why to choose', 'featured clients/ services', 'References/ qualifications', 'Contact Us/Mailto/Callto'"

    it "has a flex background video on initial load"

    it "provides an animated gif for mobile use"

    it "adheres to accessibility recommendations"

  end #main content
end #the Home page
