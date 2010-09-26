class ActiveRecord::Base
  include EnumerateIt
end

class EnumerateIt::Base
  def self.to_sorted_a
    self.to_a.sort{|x,y| x[1] <=> y[1] }
  end
end

class DegreeRequirement < EnumerateIt::Base
  associate_values(
    :none           => [0, '不限'],
    :junior_college => [1, '大专及以上'],
    :bachelor       => [2, '本科及以上'],
    :master         => [3, '硕士及以上'],
    :doctor         => [4, '博士及以上']
  )
end

class WorkingYearRequirement < EnumerateIt::Base
  associate_values(
    :none => [0, '不限'],
    :a    => [1, '1年以上'],
    :b    => [2, '2年以上'],
    :c    => [3, '3年以上'],
    :d    => [4, '5年以上'],
    :e    => [5, '10年以上']
  )
end

class SalaryRange < EnumerateIt::Base
  associate_values(
    :none   => [0, '面议'],
    :a      => [1, '1000以下'],
    :b      => [2, '1000-3000'],
    :c      => [3, '3000-5000'],
    :d      => [4, '5000-7000'],
    :e      => [5, '7000-10000'],
    :f      => [6, '10000-15000'],
    :g      => [7, '15000-20000'],
    :h      => [8, '20000以上']
  )
end

class PeriodType < EnumerateIt::Base
  associate_values(
    :daily   => [1, '每天'],
    :weekly  => [7, '每周'],
    :monthly => [30, '每月']
  )
end

class AdPositionType < EnumerateIt::Base
  associate_values(
    :slider_ad        => [1, '首页滚动图片'],
    :urgent_job       => [2, '紧急招聘'],
    :famous_company   => [3, '知名企业招聘'],
    :featured_company => [4, '推荐企业']
  )
end

class AdType < EnumerateIt::Base
  associate_values(
    :inline    => [1, '文中嵌入'],
    :job_board => [2, '专栏'],
    :widget    => [3, '列表部件'],
    :banner    => [4, '图片']
  )
end

class ServingTargetType < EnumerateIt::Base
  associate_values(
    :jobseeker => [1, '求职者'],
    :company    => [2, '公司']
  )
end

class Degree < EnumerateIt::Base
  associate_values(
    :highschool => [1, '高中'],
    :college    => [2, '大专'],
    :bachelor   => [3, '本科'],
    :master     => [4, '硕士'],
    :doctor     => [5, '博士']
  )
end

class Gender < EnumerateIt::Base
  associate_values(
    :male      => [1, '男'],
    :female    => [2, '女']
  )
end

class CompanySize < EnumerateIt::Base
  associate_values(
    :small      => [1, '小型 1-50 人'],
    :medium     => [2, '中型 50-100 人'],
    :large      => [3, '大型 100-500 人'],
    :very_large => [4, '超大型 500 人以上']
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
