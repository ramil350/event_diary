require 'rails_helper'

describe 'Profile page' do
  let!(:user) { FactoryGirl.create(:user) }

  subject { page }

  context 'authenticated' do
    before do
      login_as user
      visit user_path(user)
    end

    it { should have_css('div.panel-heading', text: user.display_name) }
    it { should have_xpath("//img[@src='#{photo_url_for(user)}']") }
    it { should have_selector('strong', text: user.email) }
    it { should have_selector('strong', text: user.display_name) }
    it { should have_link('Edit profile', href: edit_user_registration_path(user)) }
  end

  context 'unauthenticated' do
    before { visit user_path(user) }

    it { should_not have_link('Edit profile', href: edit_user_registration_path(user)) }
  end
end