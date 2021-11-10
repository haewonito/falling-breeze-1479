require "rails_helper"

RSpec.describe "plots index page", type: :feature do
  describe "US1: as a visitor" do
    before(:each) do
      @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
      @library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
      @other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

      @plot25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
      @plot26 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
      @plot2 = @library_garden.plots.create!(number: 2, size: "Small", direction: "South")
      @plot738 = @other_garden.plots.create!(number: 738, size: "Medium", direction: "West")

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

      visit "/plots"
      #plot25 has rose, lily and hyacinth
      #plot2 has rose, lily hyacinth and tulip
      #plot26 has hyacinth and tulip

      #rose has plots 25, 2
      #lily has plots 25, 2
      #hyacinth has plots 25, 2, 26
      #tulip has plots 2, 26
    end
    it "I see a list of all plot numbers" do
      expect(page).to have_content("25")
      expect(page).to have_content("26")
      expect(page).to have_content("2")
      expect(page).to have_content("738")
    end

    xit "under each plot number I see names of all associated plants" do
      within ("div#plot#{@plot25.number}") do
        expect(page).to have_content("Rose")
        expect(page).to have_content("Lily")
        expect(page).to have_content("Hyacinth")
      end
    end
  end
  describe "US2: remove a plant from a plot as a visitor" do

    before(:each) do
      @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
      @library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
      @other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

      @plot25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")

      @rose = Plant.create!(name: 'Rose', description: 'It has lots of petals and we have way too many.', days_to_harvest: 90)
      @lily = Plant.create!(name: 'Lily', description: 'Long and Elegant.', days_to_harvest: 40)
      @hyacinth = Plant.create!(name: 'Hyacinth', description: 'Usually purple or white.', days_to_harvest: 200)
      @tulip = Plant.create!(name: 'Tulip', description: 'Sturdy and reliable.', days_to_harvest: 90)

      PlotPlant.create!(plot_id: @plot25.id, plant_id: @rose.id)
      PlotPlant.create!(plot_id: @plot25.id, plant_id: @lily.id)
      PlotPlant.create!(plot_id: @plot25.id, plant_id: @hyacinth.id)

      visit "/plots"
      #plot25 has rose, lily and hyacinth

      #rose has plots 25, 2
      #lily has plots 25, 2
      #hyacinth has plots 25, 2, 26
      #tulip has plots 2, 26
    end

    it "I see a link next to each plant to remove that plant from the plot" do
      click_on "Remove #{@rose.name}"

      expect(current_path).to eq("/plots")
      expect(page).to_not have_content("Rose")
      expect(page).to have_content("Lily")
    end
  end

end
