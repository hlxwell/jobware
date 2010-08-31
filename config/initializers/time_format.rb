class Time
  def to_s_full_cn
    self.strftime("%Y年%m月%d日")
  end
  
  def to_s_detail
    self.strftime("%Y年%m月%d日 %H:%M:%S")
  end
end