require 'capybara/rspec'
require 'spec_helper'
require 'rails_helper'
require 'rspec-html-matchers'

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

    it "uses microdata markup to indicate hours of operation, and products"

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

  end #conforms to SEO

  describe "conforms to usability recommendations" do

    it "has an alt attribute for every image" do
      expect(page.body.scan(/<img.*>/).count).to be(page.body.scan(/<img.*alt='.*'.*>/).count)
    end #case alt attribute on images

    it "has an alt attribute for every video" do
      expect(page.body.scan(/<video.*>/).count).to be(page.body.scan(/<video.*alt='.*'.*>/).count)
    end #case alt attribute on video

    it "presents phone contact information prominently (header)" do
      expect(page.find('footer')).to have_selector('.phone-info',      text: APP_CONFIG['contact_phone'])
    end #case phone contact info

    it "presents email contact information prominently (header)" do
      expect(page.find('footer')).to have_selector('.email-info',      text: APP_CONFIG['contact_email_sales'])
    end #case presents email contact info

    it "presents street address in the footer" do
      expect(page.find('footer')).to have_selector('.street',     text: APP_CONFIG['contact_address'])
      expect(page.find('footer')).to have_selector('.suite',      text: APP_CONFIG['contact_suite'])
    end #case street address

    it "presents city, state and zip in the footer" do
      expect(page.find('footer')).to have_selector('.city',       text: APP_CONFIG['contact_city'])
      expect(page.find('footer')).to have_selector('.state',      text: APP_CONFIG['contact_state'])
      expect(page.find('footer')).to have_selector('.postal',     text: APP_CONFIG['contact_postal'])
    end #case city state zip

    it "presents an Inherent Knowledge contact email as webmaster in the footer" do
      expect(page.find('footer')).to have_selector('.webmaster',  text: '@inherent-knowledgellc.com')
    end #case Inherent Knowledge contact

    it "presents an Inherent Knowledge copyright notice" do
      expect(page.find('.inh_kn_copy')).to have_content('C 2014 Inherent Knowledge, LLC.  All Rights Reserved.')
    end #case copyright

    it "presents a publication date (footer)" do
      expect(page.find('footer')).to have_selector('.publication',       text: '10/14/2014')
    end #case publication date

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
