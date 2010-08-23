class Company < ActiveRecord::Base
  attr_accessible :user_id, :name, :type, :size, :province, :city, :address, :homepage, :contact_name, :phone_number, :desc
end
