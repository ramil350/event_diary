require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  describe 'attributes' do
    subject { user }

    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should respond_to(:full_name) }
  end

  describe '#display_name' do
    subject { user.display_name }

    context 'full_name is assigned' do
      let(:name) { Faker::Name::first_name }

      before { user.update_attributes(full_name: name) }

      it { should eq(name) }
    end

    context 'full_name is empty' do
      let(:email) { Faker::Internet::email }

      before { user.update_attributes(full_name: nil, email: email) }

      it { should eq(email) }
    end
  end
end
