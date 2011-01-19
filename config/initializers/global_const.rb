THEMES = {
  "rails"    => ["Ruby/Rails", "ruby on rails"],
  "php"      => ["PHP", "php, lamp"],
  "java"     => ["JAVA", "java, Hibernate, Spring, Struts, iBATIS, JBoss, JSF, Groovy, Lucene"],
  "dotnet"   => [".Net", "c#.net vb.net asp.net"],
  "python"   => ["Python", "python, django", false],
  "designer" => ["UI", "美工设计, html, div, css, javascript, jquery", false],
  "iphone"   => ["iOS, Cocoa", "cocoa, ios, iphone, objective-c, xcode, 移动开发, mobile"],
  "android"  => ["Android", "android", false],
  "database" => ["数据库", "数据库, mysql, oracle, sql server", false],
  "c"        => ["C/C++", "c, c++, vc, 嵌入式开发"],
  "game"     => ["游戏", "游戏开发, web游戏, 桌面游戏, 网络游戏", false],
  "ria"      => ["RIA", "flash, flex, silverlight, ActionScript", false]
}
PRESERVED_SUBDOMAINS = %w{www help} + THEMES.keys