require 'spec_helper'

RSpec.describe Magic::Cards::RoamingGhostlight do
  include_context "two player game"

  subject { Permanent("Roaming Ghostlight", controller: p1) }

  before do
    game.battlefield.add(subject)
  end

  context "when it enters the battlefield" do

    it "return up to one target non-Spirit creature to its owner’s hand"

  end
end
