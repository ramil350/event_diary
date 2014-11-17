shared_examples_for 'action redirecting to user calendar' do
  it 'redirects' do
    expect(response).to redirect_to(my_calendar_path)
  end
end