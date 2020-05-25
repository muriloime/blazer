require 'rails_helper'

RSpec.feature 'User can see page' do
  scenario '/blazer' do
    visit blazer_path
    expect(page).to have_content('New Dashboard')
    expect(page).to have_content('New Check')
    expect(page).to have_content('New Query')
  end

  scenario 'queries#new' do
    visit 'blazer/queries/new'
    expect(page).to have_content('Back')
    expect(page).to have_content('Docs')
    expect(page).to have_content('Schema')
  end

  scenario 'dashboards#new' do
    visit 'blazer/dashboards/new'
    expect(page).to have_content('Charts')
    expect(page).to have_content('Add Chart')
    expect(page).to have_content('Back')
  end

  scenario 'checks#index' do
    visit 'blazer/checks'
    expect(page).to have_content('Home')
    expect(page).to have_content('New Query')
    expect(page).to have_content('New Dashboard')
  end
end
