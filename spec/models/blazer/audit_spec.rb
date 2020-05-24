
require 'rails_helper'

RSpec.describe Blazer::Audit, type: :model do
  it 'simple first test' do
    audit = FactoryBot.build(:audit)

    expect(audit.class).to eq(described_class)
  end
end