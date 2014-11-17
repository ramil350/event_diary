require 'rails_helper'

describe EventsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe 'GET new' do
    before { get :new, user_id: user.id }

    it 'assigns @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST create' do
    before { post :create, event: event_params }

    context 'with valid params' do
      let(:event_params) { { user_id: user.id, title: 'New event', starts_on: Date.today, recurring: false, repeats: '' } }

      it_behaves_like 'action redirecting to user calendar'
    end

    context 'with invalid params' do
      let(:event_params) { { title: '' } }

      it 'renders new' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET edit' do
    let(:event) { FactoryGirl.create(:event) }

    before { get :edit, id: event.id }

    it 'should assign @event' do
      expect(assigns(:event)).to eq(event)
    end

    it 'should render edit' do
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH update' do
    let(:event) { FactoryGirl.create(:event) }
    let(:event_params) { { title: 'New title', starts_on: Date.today } }

    before { patch :update, id: event.id, event: event_params }

    context 'valid params' do
      it 'should assign @event' do
        expect(assigns(:event)).to eq(event)
      end

      it_behaves_like 'action redirecting to user calendar'
    end

    context 'invalid params' do
      let(:event_params) { { title: '' } }

      it 'should render edit' do
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE' do
    let(:event) { FactoryGirl.create(:event) }

    before { delete :destroy, id: event.id }

    it 'should delete event' do
      expect(Event.count).to be_zero
    end

    it_behaves_like 'action redirecting to user calendar'
  end
end