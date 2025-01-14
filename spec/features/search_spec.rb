require "rails_helper"

RSpec.describe "Search for Members" do
  describe "'search" do

    # As a user,
    # When I visit "/"
    # And I Select "Fire Nation" from the select field
    # (Note: Use the existing select field)
    # And I click "Search For Members"
    # Then I should be on page "/search"
    # Then I should see the total number of people who live in the Fire Nation. (should be close to 100)
    # And I should see a list with the detailed information for the first 25 members of the Fire Nation.

    # And for each of the members I should see:
    # - The name of the member (and their photo, if they have one)
    # - The list of allies or "None"
    # - The list of enemies or "None"
    # - Any affiliations that the member has

    it "displays Fire Nation members" do
      json_response = File.read("spec/fixtures/fire_nation.json")

      stub_request(:get, "https://last-airbender-api.fly.dev/api/v1/characters?affiliation=fire%20nation").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.12'
           }).
         to_return(status: 200, body: json_response, headers: {})

      visit "/"

      select "Fire Nation", :from => :nation

      click_on "Search For Members"

      expect(current_path).to eq "/search"
      # save_and_open_page
      expect(page).to have_content("Total Number of People: 20")
      expect(page).to have_content("Member Details:")
      expect(page).to have_content("Name: Azula")
      expect(page).to have_content("Name: Chan")
      expect(page).to have_content("Photo:")
      expect(page).to have_content("Allies:")
      expect(page).to have_content("Enemies:")
      expect(page).to have_content("Affiliations:")
    end
  end
end