require 'rails_helper'

describe UsersHelper do
  describe 'photo_for_url' do
    let(:user) { FactoryGirl.create(:user) }
    let(:email) { user.email.downcase }
    let(:email_hash) { Digest::MD5.hexdigest(user.email) }
    let(:image_size) { 10 }
    let(:expected_url) { "http://www.gravatar.com/avatar/#{email_hash}?s=#{image_size}" }

    it 'should return avatar url form email' do
      expect(helper.photo_url_for(user, image_size)).to eq(expected_url)
    end
  end
end