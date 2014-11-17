class EventScheduleQuery
  def initialize(relation)
    @relation = relation
  end

  def build(date_start, date_end)
    period_start = ActiveRecord::Base.sanitize(date_start)
    period_end = ActiveRecord::Base.sanitize(date_end)
    @relation.joins(query_body(period_start, period_end))
      .select('events.*, dates.date AS schedule_date')
      .where('events.id IS NOT NULL')
      .order('schedule_date')
  end

  private

  def query_body(period_start, period_end)
    <<-EOS
      RIGHT OUTER JOIN generate_series(#{period_start}, #{period_end}, INTERVAL '1 DAY') dates
      ON (events.recurring = false AND dates.date = events.starts_on) OR
         (events.recurring = true AND events.starts_on <= dates.date AND
           (
             (events.repeats = 'daily') OR
             (events.repeats = 'yearly' AND to_char(events.starts_on, 'MM-DD') = to_char(dates.date, 'MM-DD')) OR
             (events.repeats = 'monthly' AND to_char(events.starts_on, 'DD') = to_char(dates.date, 'DD')) OR
             (events.repeats = 'weekly' AND date_part('DAY', dates.date::timestamp - events.starts_on::timestamp)::integer % 7 = 0)
           )
         )
    EOS
  end
end