require 'rails_helper'

describe 'Home page' do
  before { visit root_path }

  subject { page }

  it { should have_css('.navbar-brand', text: 'EVY') }

  context 'unauthenticated' do
    it { should have_link('Log in', href: new_user_session_path) }
    it { should have_link('Sign up', href: new_user_registration_path) }
    it { should_not have_link('Log out') }
  end

  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    it { should have_link('Calendar') }
    it { should have_link('Profile', href: user_path(user)) }    
    it { should have_link('Log out', href: destroy_user_session_path) }    
  end

end