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

      it 'creates a new event' do
        expect(response).to redirect_to(user_calendar_path(user))
      end
    end

    context 'with invalid params' do
      let(:event_params) { { title: '' } }

      it 'renders new' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET index' do
    let!(:event1) { FactoryGirl.create(:event, user: user, starts_on: Date.today) }
    let!(:event2) { FactoryGirl.create(:event, starts_on: Date.today) }
    let!(:event3) { FactoryGirl.create(:event, user: user, starts_on: Date.tomorrow) }
    let(:start_date) { Date.today }
    let(:end_date) { start_date }
    let(:expected_json) { [event1].to_json }

    before { get :index, { start: start_date, end: end_date, format: :json } }

    it 'should return events as json' do
      expect(response.body).to eq(expected_json)
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

      it 'should redirect to calendar' do
        expect(response).to redirect_to(user_calendar_path(user))
      end
    end

    context 'invalid params' do
      let(:event_params) { { title: '' } }

      it 'should render edit' do
        expect(response).to render_template('edit')
      end
    end
  end
end