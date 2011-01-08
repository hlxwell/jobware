module ViewsCountable
  def increased_views_count
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.try(:increment!, :click)
    update_views_count
    views_count_s
  end

  def set_random_views_count
    random_clicks = rand(1000)
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.update_attribute(:click, random_clicks)
    self.views_count = random_clicks
    update_views_count
  end
end