class CreditType < EnumerateIt::Base
  associate_values(
    :money            => [1, '人名币'],
    :job              => [2, '岗位发布'],
    :ad               => [3, '广告发布'],
    :resume_highlight => [4, '简历高亮服务'],
    :sms_alert        => [5, '短信服务']
  )
end