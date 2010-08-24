class CompanySize < EnumerateIt::Base
  associate_values(
    :small      => [1, '小型 1-50'],
    :medium     => [2, '中型 50-100'],
    :large      => [3, '大型 100-500'],
    :very_large => [4, '超大型 500-1000']
  )
end
