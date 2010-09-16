class CompanyObserver < ActiveRecord::Observer
  def after_create(company)
    company.partner.try(:increase_company)
  end
end