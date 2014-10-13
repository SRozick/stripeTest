require 'capybara/rspec'
require 'spec_helper'

RSpec.describe "the Home page" do

  before (:each) do
    visit root_path
  end #before

  describe "conforms to SEO best practices" do
    let(:meta_description) { "Is your website working for you\\? We specialize in e-commerce, SEO, and mobile design for small business.  Contact us for a free quote to help build your brand!" }

    it "has exactly one title tag" do
      expect(page.body.scan(/<title>/).count).to be 1
    end #case has one title

    it "has a title of Inherent Knowledge, LLC" do
      expect(page).to have_title('Inherent Knowledge, LLC')
    end #case title

    it "has a title less than 70 characters long" do
      expect(page.title.length).to be < 70
    end #case title_max length

    it "has exactly one <h1> tag" do
      expect(page.body.scan(/<h1>/).count).to be 1
    end #case h1 tag

    it "has different text in the page title and h1 tags" do
      expect(page.title).to_not eq(page.find('h1').text)
    end #case different text

    it "has a meta description tag" do
      expect(page.body.scan(/<meta.*name='description.*>/).count).to be 1
    end #case meta desc tag

    it "has relevant meta description text" do
      expect(page.body).to match(/<meta.*content='#{meta_description}'.*>/)
    end #meta desc text

    it "has a meta description of appropriate length" do
      expect(meta_description.length).to be <= 165
    end #case meta desc appropriate length

    it "has a canonical link tag" do
      expect(page.body.scan(/<link.*rel='canonical'.*>/).count).to be 1
    end #case canonical

    it "links to at least 3 reputable other sites"

    it "uses microdata markup to indicate location, hours, and products"
    # see https://support.google.com/webmasters/answer/176035
    #http://schema.org/
    #https://support.google.com/webmasters/answer/146750

  end #conforms to SEO

  describe "conforms to usability recommendations" do

    it "has an alt attribute for every image" do
      expect(page.body.scan(/<img.*>/).count).to be(page.body.scan(/<img.*alt='.*'.*>/).count)
    end #case alt attribute on images

    it "has an alt attribute for every video" do
      expect(page.body.scan(/<video.*>/).count).to be(page.body.scan(/<video.*alt='.*'.*>/).count)
    end #case alt attribute on video

    it "presents contact information prominently (header)"

    it "presents a publication date (footer)"

    it "presents a last updated date (footer)"

    it "presents a copyright notice (footer)"

  end #conforms to usability

  describe "has a menu bar" do

    it "links to blog, portfolio, services, and contact pages (menu)" do
      expect(page).to have_selector("Inherent Knowledge")
    end #case menu

    it "links to home page" do
      expect(page).to have_link("Home")
    end #case menu

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

  end #main content
end #the Home page
