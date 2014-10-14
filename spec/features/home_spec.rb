require 'capybara/rspec'
require 'spec_helper'
require 'rails_helper'

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

    it "presents contact information prominently (header)" do
      expect(page).to have_tag('footer') do
        with_tag '.phone',        text: APP_CONFIG['contact_phone']
        with_tag '.email',        text: APP_CONFIG['contact_email_sales']
      end #have_tag
    end #case presents header contact info

    it "presents contact information in the footer" do
      expect(page).to have_tag('footer') do
        with_tag '.street',       text: APP_CONFIG['contact_address']
        with_tag '.suite',        text: APP_CONFIG['contact_suite']
        with_tag '.city',         text: APP_CONFIG['contact_city']
        with_tag '.state',        text: APP_CONFIG['contact_state']
        with_tag '.postal',       text: APP_CONFIG['contact_postal']
        with_tag '.webmaster',    text: APP_CONFIG['contact_email_web']
      end #have_tag
    end #case presents header contact info

    it "presents a publication date (footer)"

    it "presents a last updated date (footer)"

#TODO: Refactor to match config/config.yml value for copyright
    it "presents a copyright notice (footer)" do
      expect(page).to have_tag('footer') do
        with_tag 'div.copyright', text: APP_CONFIG['copyright_notice']
      end #have_tag
    end #case copyright

  end #conforms to usability

  describe "has a menu bar" do

    it "links to blog, portfolio, services, and contact pages (menu)" do
      expect(page).to have_tag('nav.tab-bar') do
        with_tag 'section.left-small'
      end #have_tag
    end #case menu

    it "has an accessible left side menu" do
      expect(page).to have_tag('nav.tab-bar') do
        with_tag 'section.left-small'
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

    it "goes to the Home page when the Home link is clicked" do
      visit root_path
      within ('nav.left-off-canvas-menu') do
        click_link 'Home'
      end #within
      expect(page).to have_http_status(:success)
      expect(page).to have_content(/hello inherent knowledge/i)
    end #case Home link

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
