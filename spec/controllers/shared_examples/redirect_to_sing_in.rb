shared_examples_for 'action redirecting to sign in' do |action|
  before { get action }

  it 'redirects' do
    expect(response).to redirect_to(new_user_session_path)
  end
end