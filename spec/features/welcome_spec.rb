require 'rails_helper'

describe "When I visit the root welcome page" do
  xit "Shows me links to the possible endpoints" do
    visit '/'
    expect(page).to have_content('Welcome')
  end
end
