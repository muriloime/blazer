require 'rails_helper'

RSpec.describe Blazer::Query, type: :model do
  it 'to_param concatenates id and name' do
    query = FactoryBot.build(:query, id: 1)

    expect(query.to_param).to eq('1-name')
  end

  it 'has friendly_name' do
    query = FactoryBot.build(:query, name: '#123 Complex Name [123]')

    expect(query.friendly_name).to eq('123 Complex Name')
  end

  it 'is editable? if name starts with #' do
    user = FactoryBot.build(:user)
    query = FactoryBot.build(:query, name: '#name')

    expect(query.editable?(user)).to be(true)
  end
end
