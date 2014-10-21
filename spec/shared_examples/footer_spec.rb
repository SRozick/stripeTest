RSpec.shared_examples_for "a page with a standard footer" do

  let(:footer) { page.find('footer') }

  it "presents phone contact information" do
    expect(footer).to have_selector('.phone-info',      text: APP_CONFIG['contact_phone'])
  end #case phone contact info

  it "presents email contact information" do
    expect(footer).to have_selector('.email-info',      text: APP_CONFIG['contact_email_sales'])
  end #case presents email contact info

  it "presents street address in the footer" do
    expect(footer).to have_selector('.street',          text: APP_CONFIG['contact_address'])
    expect(footer).to have_selector('.suite',           text: APP_CONFIG['contact_suite'])
  end #case street address

  it "presents city, state and zip in the footer" do
    expect(footer).to have_selector('.city',            text: APP_CONFIG['contact_city'])
    expect(footer).to have_selector('.state',           text: APP_CONFIG['contact_state'])
    expect(footer).to have_selector('.postal',          text: APP_CONFIG['contact_postal'])
  end #case city state zip

  it "presents an Inherent Knowledge contact email as webmaster in the footer" do
    expect(footer).to have_selector('.webmaster',       text: '@inherent-knowledgellc.com')
  end #case Inherent Knowledge contact

  it "presents an Inherent Knowledge copyright notice" do
    expect(footer).to have_selector('.inh_kn_copy',     text: APP_CONFIG['inh_kn_copy'])
    # expect(page.find('.inh_kn_copy')).to have_content(APP_CONFIG['inh_kn_copy'])
  end #case copyright

  it "presents a publication date (footer)" do
    expect(footer).to have_selector('.publication',     text: '10/14/2014')
  end #case publication date

end
