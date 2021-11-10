require "rails_helper"

RSpec.describe Plant, type: :model do
  describe "relationships" do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants)}
  end

  describe "class methods" do
    it "" do

    end
  end
end
