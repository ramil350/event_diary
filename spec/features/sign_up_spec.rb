require 'rails_helper'

describe 'Sign up' do
  before do
    visit new_user_registration_path

    fill_in 'user_full_name', with: new_user.full_name
    fill_in 'user_email', with: new_user.email
    fill_in 'user_password', with: new_user.password
    fill_in 'user_password_confirmation', with: new_user.password_confirmation

    click_button 'Sign up'
  end

  context 'with valid info' do
    let(:new_user) { FactoryGirl.build(:user) }

    it 'should render success message' do
      expect(page).to have_text('Welcome! You have signed up successfully.')
    end

    it 'should create a new user' do
      expect(User.find_by_email(new_user.email)).to be_persisted
    end
  end

  context 'with invalid info' do
    let(:new_user) { FactoryGirl.build(:user, email: 'invalid_email') }

    it 'should render error message' do
      expect(page).to have_css('div#error_explanation')
    end
  end
end