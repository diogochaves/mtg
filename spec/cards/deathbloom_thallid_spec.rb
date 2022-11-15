require 'spec_helper'

RSpec.describe Magic::Cards::DeathbloomThallid do
  include_context "two player game"

  let(:deathbloom_thallid) { ResolvePermanent("Deathbloom Thallid", controller: p1) }

  context "when Deathbloom Thallid dies" do
    it "creates a 1/1 green saproling creature tokens" do
      deathbloom_thallid.destroy!
      expect(p1.creatures.by_name("Saproling").count).to eq(1)
    end
  end
end
