require 'rails_helper'

describe 'Home page' do
  before { visit root_path }

  subject { page }

  context 'unauthenticated' do
    it { should have_css('.navbar-brand', text: 'EVY') }
    it { should have_link('Log in', href: new_user_session_path) }
    it { should have_link('Sign up', href: new_user_registration_path) }
    it { should_not have_link('Log out') }
  end

  # TODO:
  # authenticated

end