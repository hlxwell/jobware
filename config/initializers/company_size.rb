class CompanySize < EnumerateIt::Base
  associate_values(
    :small      => [1, '1-50'],
    :medium     => [2, '50-100'],
    :large      => [3, '100-500'],
    :very_large => [4, '500-1000']
  )
end
