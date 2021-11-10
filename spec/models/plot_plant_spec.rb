require "rails_helper"

RSpec.describe PlotPlant, type: :model do
  describe "relationship" do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end

  describe "class methods" do
    xit "" do

    end
  end
end
