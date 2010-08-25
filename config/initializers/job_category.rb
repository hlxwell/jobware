class JobCategory < EnumerateIt::Base
  associate_values(
    :designer   => [1, 'UI设计师'],
    :programmer => [2, '程序开发'],
    :dba        => [3, '数据库管理'],
    :sa         => [4, '系统管理']
  )
end