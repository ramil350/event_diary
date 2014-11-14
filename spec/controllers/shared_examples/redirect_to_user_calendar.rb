shared_examples_for 'action redirection to user calendar' do
  it 'creates a new event' do
    expect(response).to redirect_to(user_calendar_path(user))
  end
end