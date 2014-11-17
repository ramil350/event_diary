shared_examples_for 'calendar action' do |action|
  context 'format html' do
    before { get action }

    it 'renders index' do
      template = action == :index ? 'index' : 'user_calendar'
      expect(response).to render_template(template)
    end
  end

  context 'format json' do
    before { get action, { start: start_date, end: end_date, format: :json } }

    it 'should return events as json' do
      expect(response.body).to eq(expected_json)
    end
  end
end