require 'rails_helper'

describe 'Home page' do
  before { visit root_path }

  subject { page }

  it { should have_selector('h1', text: 'EVY') }
end