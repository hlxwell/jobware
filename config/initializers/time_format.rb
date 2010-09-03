module CnFormatter
  def to_s_date
    self.strftime("%Y年%m月%d日")
  end
  
  def to_s_datetime
    self.strftime("%Y年%m月%d日 %H:%M:%S")
  end
  
  def to_s_time
    self.strftime("%H:%M:%S")
  end
end

class Time
  include CnFormatter
end

class Date
  include CnFormatter
end