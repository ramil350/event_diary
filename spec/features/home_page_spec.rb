require 'rails_helper'

describe 'Home page' do
  subject { page }

  context 'unauthenticated' do
    before { visit root_path }

    it { should have_css('.navbar-brand', text: 'Event Diary') }
    it { should have_link('Log in', href: new_user_session_path) }
    it { should have_link('Sign up', href: new_user_registration_path) }
    it { should_not have_link('Log out') }
  end

  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      login_as user
      visit root_path
    end

    it { should have_xpath("//img[@src='#{photo_url_for(user, 22)}']") }
    it { should have_link(user.display_name, href: user_path(user)) }
    it { should have_link('Public', href: public_calendar_path) }
    it { should have_link('My events', href: my_calendar_path) }
    it { should have_link('Profile', href: user_path(user)) }
    it { should have_link('Log out', href: destroy_user_session_path) }
  end
end