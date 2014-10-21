RSpec.shared_examples_for "a page that is SEO-compliant" do

# Title Behavior
  it "has exactly one title tag" do
    expect(page.body.scan(/<title>/).count).to eq(1)
  end #case has one title

  it "has a title less than 70 characters long" do
    expect(page.title.length).to be < 70
  end #case title_max length

  it "has a title of Inherent Knowledge, LLC" do
    expect(page).to have_title('Inherent Knowledge, LLC')
  end #case title

# Prominent header behavior
  it "has exactly one <h1> tag" do
    expect(page.body.scan(/<h1>/).count).to eq(1)
  end #case h1 tag

  it "has different text in the page title and h1 tags" do
    expect(page.title).to_not eq(page.find('h1').text)
  end #case different text

  it "has relevant meta description text" do
    # expect(page.body).to match(/<meta.*content='#{meta_description}'.*>/)
    expect(page.body).to match(/<meta.*content="#{meta_description}".*>/)
  end #meta desc text

# Meta tag behavior
  it "has a meta description tag" do
    expect(page.body.scan(/<meta.*name="description.*>/).count).to eq(1)
  end #case meta desc tag

  it "has a meta description of appropriate length" do
    expect(meta_description.length).to be <= 165
  end #case meta desc appropriate length

# Canonical behavior
# TODO: Check regex, behaves differently if "" and '' are reversed
  it "has a canonical link tag" do
    expect(page.body.scan(/<link rel ?= ?('canonical')|("canonical").*>/).count).to eq(1)
  end #case


# Descriptive element behavior
  it "has an alt attribute for every video" do
    expect(page.body.scan(/<video.*>/).count).to be(page.body.scan(/<video.*alt=("|').*("|').*>/).count)
  end #case alt attribute on video

  it "has an alt attribute for every image" do
    expect(page.body.scan(/<img.*>/).count).to eq(page.body.scan(/<img.*alt=("|').*("|').*>/).count)
  end #case alt attribute on images

end
