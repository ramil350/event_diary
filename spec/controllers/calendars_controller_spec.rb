require 'rails_helper'

describe CalendarsController, type: :controller do

  context 'unauthenticated' do
    before { get :index }

    it 'should redirect to sign in' do
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      get :index
    end

    it 'renders index' do
      expect(response).to render_template('index')
    end
  end
end