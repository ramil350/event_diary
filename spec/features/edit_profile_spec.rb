require 'rails_helper'

describe 'Edit profile' do
  let(:user) { FactoryGirl.create(:user) }

  context 'authenticated' do
    let(:new_name) { 'Mike' }
    let(:new_email) { Faker::Internet::email }
    let(:new_password) { 'new_password' }
    let(:user_attributes) do
      {
        full_name: user.reload.full_name,
        email: user.reload.email,
        password: user.reload.valid_password?(new_password) ? new_password : ''
      }
    end

    let(:new_attributes) do
      {
        full_name: new_name,
        email: new_email,
        password: new_password
      }
    end

    before do
      login_as user
      visit user_path(user)
      click_link 'Edit profile'

      fill_in 'Full name', with: new_name
      fill_in 'Email', with: new_email
      fill_in 'Password', with: new_password
      fill_in 'Password confirmation', with: new_password
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it 'should succeed' do
      expect(page).to have_text('Your account has been updated successfully.')
    end

    it 'should update user' do
      expect(user_attributes).to eq(new_attributes)
    end
  end
end