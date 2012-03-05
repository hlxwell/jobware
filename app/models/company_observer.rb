# -*- encoding : utf-8 -*-
class CompanyObserver < ActiveRecord::Observer

  def before_save(company)
    company.homepage = company.homepage.gsub(/^(http:\/\/)?/, "http://")
  end

  def after_create(company)
    company.partner.try(:increase_company)
  end
end
