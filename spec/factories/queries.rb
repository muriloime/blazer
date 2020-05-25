FactoryBot.define do
  factory :query, class: Blazer::Query do
    creator_id { 1 }
    name { 'name' }
    description { 'description' }
    statement { 'statement' }
    data_source { 'data_source' }
  end
end
