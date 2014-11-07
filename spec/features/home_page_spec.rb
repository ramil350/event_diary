require 'rails_helper'

describe 'Home page' do
  before { visit root_path }

  subject { page }

  it { should have_selector('h1', text: 'EVY') }
  it { should have_link('Sign in', href: new_user_session_path) }
  it { should have_link('Sign up', href: new_user_registration_path) }
end