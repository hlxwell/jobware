class ActiveRecord::Base
  include EnumerateIt
end


class Gender < EnumerateIt::Base
  associate_values(
    :male      => [1, '男'],
    :female    => [2, '女']
  )
end

class CompanySize < EnumerateIt::Base
  associate_values(
    :small      => [1, '小型 1-50'],
    :medium     => [2, '中型 50-100'],
    :large      => [3, '大型 100-500'],
    :very_large => [4, '超大型 500-1000']
  )
end

class CompanyType < EnumerateIt::Base
  associate_values(
    :private     => [1, '私营'],
    :country     => [2, '国营'],
    :foreign     => [3, '外资'],
    :joint_stock => [4, '合资'],
    :other       => [4, '其他']
  )
end

class ContractType < EnumerateIt::Base
  associate_values(
    :fulltime   => [1, '全职'],
    :parttime   => [2, '兼职'],
    :freelancer => [3, '自由职业'],
    :intern     => [4, '实习']
  )
end

class JobCategory < EnumerateIt::Base
  associate_values(
    :designer   => [1, 'UI设计师'],
    :programmer => [2, '程序开发'],
    :dba        => [3, '数据库管理'],
    :sa         => [4, '系统管理']
  )
end

class SiteSize < EnumerateIt::Base
  associate_values(
    :small      => [1, '每日小于 100 IP'],
    :medium     => [2, '每日 100-1000 IP'],
    :large      => [3, '每日 1000-10000 IP'],
    :very_large => [4, '每日 10000 IP以上']
  )
end

class WorkingState < EnumerateIt::Base
  associate_values(
    :working    => [1, '在职'],
    :no_job     => [2, '失业中'],
    :freelancer => [3, '自由职业']
  )
end
