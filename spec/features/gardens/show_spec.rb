require "rails_helper"

RSpec.describe "garden show page", type: :feature do
  describe "US3: as a visitor, when I visit a garden's show page" do
    before(:each) do
      @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

      @plot2 = @turing_garden.plots.create!(number: 2, size: "Small", direction: "South")
      @plot25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
      @plot26 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")

      @rose = Plant.create!(name: 'Rose', description: 'It has lots of petals and we have way too many.', days_to_harvest: 90)
      @lily = Plant.create!(name: 'Lily', description: 'Long and Elegant.', days_to_harvest: 40)
      @hyacinth = Plant.create!(name: 'Hyacinth', description: 'Usually purple or white.', days_to_harvest: 200)
      @tulip = Plant.create!(name: 'Tulip', description: 'Sturdy and reliable.', days_to_harvest: 90)

      PlotPlant.create!(plot_id: @plot25.id, plant_id: @rose.id)
      PlotPlant.create!(plot_id: @plot25.id, plant_id: @lily.id)
      PlotPlant.create!(plot_id: @plot25.id, plant_id: @hyacinth.id)

      PlotPlant.create!(plot_id: @plot2.id, plant_id: @rose.id)
      PlotPlant.create!(plot_id: @plot2.id, plant_id: @lily.id)
      PlotPlant.create!(plot_id: @plot2.id, plant_id: @hyacinth.id)
      PlotPlant.create!(plot_id: @plot2.id, plant_id: @tulip.id)

      PlotPlant.create!(plot_id: @plot26.id, plant_id: @hyacinth.id)
      PlotPlant.create!(plot_id: @plot26.id, plant_id: @tulip.id)

      visit "/gardens/#{@turing_garden.id}"
    end

    it "I see a list of distinct plants from its plots that take less than 100 days to harvest" do
      expect(page).to have_content("Rose")
      expect(page).to have_content("Lily")
      expect(page).to have_content("Tulip")
      expect(page).to_not have_content("Hyacinth")
    end
  end
end
 #figure out how to test for uniqueness
