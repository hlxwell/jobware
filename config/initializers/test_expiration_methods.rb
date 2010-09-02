module TestExpirationMethods
  def expired?(start_at, end_at)
    return :not_start_yet if Time.now < start_at
    return :started if end_at > Time.now > start_at
    return :expired if Time.now > end_at
  end
end