require 'spec_helper'

RSpec.describe Magic::Cards::ValorousSteed do
  include_context "two player game"

  subject { add_to_library("Valorous Steed", player: p1) }

  context "when Valorous Steed enters the battlefield" do
    it "creates a 2/2 white knight creature tokens" do
      cast_and_resolve(card: subject, player: p1)
      expect(p1.creatures.by_name("Knight").count).to eq(1)
    end
  end
end
