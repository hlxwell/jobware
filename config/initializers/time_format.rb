# -*- encoding : utf-8 -*-
module CnFormatter
  def to_s_short_date
    self.strftime("%m月%d日")
  end

  def to_s_date
    self.strftime("%Y年%m月%d日")
  end

  def to_s_datetime
    self.strftime("%Y年%m月%d日 %H:%M")
  end

  def to_s_time
    self.strftime("%H:%M")
  end
end

class Time
  include CnFormatter
end

class Date
  include CnFormatter
end
