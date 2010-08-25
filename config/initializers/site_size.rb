class SiteSize < EnumerateIt::Base
  associate_values(
    :small      => [1, '每日小于 100 IP'],
    :medium     => [2, '每日 100-1000 IP'],
    :large      => [3, '每日 1000-10000 IP'],
    :very_large => [4, '每日 10000 IP以上']
  )
end
