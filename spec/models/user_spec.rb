require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe 'attributes' do
    subject { user }

    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should respond_to(:full_name) }
    it { should respond_to(:events) }
  end

  describe 'associations' do
    let!(:event1) { FactoryGirl.create(:event, user: user) }
    let!(:event2) { FactoryGirl.create(:event, user: user) }
    let!(:foreign_event) { FactoryGirl.create(:event) }

    context 'events' do
      it 'should destroy its events' do
        expect { user.destroy }.to change { user.events.count }.by(-2)
      end
    end
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
