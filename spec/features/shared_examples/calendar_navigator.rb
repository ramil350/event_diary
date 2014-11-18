shared_examples_for 'calendar navigator' do
  context 'on page load', js: true do
    it { should have_selector('h2', text: Date.today.strftime('%B %Y')) }
  end

  context 'navigation', js: true do
    let(:faraway_date) { Date.today.next_year }

    before do
      fill_in 'navigation_date', with: Date.today.next_year
      click_button 'navigation_submit'
    end

    it 'should load farawway date period' do
      expect(page).to have_selector('h2', text: faraway_date.strftime('%B %Y'))
    end
  end
end