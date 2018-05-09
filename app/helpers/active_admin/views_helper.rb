#
module ActiveAdmin::ViewsHelper
  def time_ago(date)
    return nil if date.blank?
    if date.to_date > Time.zone.now.to_date
      "in #{distance_of_time_in_words(Time.zone.now, date, highest_measure_only: true)}"
    elsif date.to_date == Time.zone.now.to_date
      "Today, #{date.strftime('%Hh %M')}"
    else
      "#{distance_of_time_in_words(Time.zone.now, date, highest_measure_only: true)} ago"
    end
  end
end
