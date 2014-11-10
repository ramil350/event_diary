require 'rails_helper'

describe 'Log in' do
  before do
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_button 'Log in'
  end

  context 'with valid info' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'should render success message' do
      expect(page).to have_text('Signed in successfully.')
    end
  end

  context 'with invalid info' do
    let(:user) { FactoryGirl.build(:user, email: 'invalid_email') }

    it 'should render error message' do
      expect(page).to have_css('div#error_explanation')
    end
  end
end