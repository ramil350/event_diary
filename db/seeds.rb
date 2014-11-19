Event.destroy_all
User.destroy_all

john = User.create!(email: 'john.eventdiary@mailinator.com', password: 'password')
john.events.create!(title: 'Sprint planning', starts_on: Date.tomorrow, recurring: true, repeats: 'weekly')
john.events.create!(title: 'Meeting', starts_on: Date.today)
john.events.create!(title: 'Kelly''s birthday', starts_on: Date.parse('2014-12-20'), recurring: true, repeats: 'yearly')

tim = User.create!(email: 'tim.eventdiary@mailinator.com', password: 'password')
tim.events.create!(title: 'Backlog overview', starts_on: 2.days.from_now, recurring: true, repeats: 'monthly')
tim.events.create!(title: 'Limn Bizkit show', starts_on: 5.days.ago)
tim.events.create!(title: 'Stand up', starts_on: Date.today, recurring: true, repeats: 'daily', ends_on: 1.month.from_now)

ann = User.create!(email: 'ann.eventdiary@mailinator.com', password: 'password')
ann.events.create!(title: 'Anniversary celebration', starts_on: Date.today.next_week)
ann.events.create!(title: 'Team building', starts_on: 1.week.from_now)