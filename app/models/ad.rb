# == Schema Information
# Schema version: 20100831035618
#
# Table name: ads
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  position   :integer(4)
#  type       :integer(4)
#  url        :string(255)
#  state      :string(255)
#  start_at   :date
#  end_at     :date
#  created_at :datetime
#  updated_at :datetime
#

class Ad < ActiveRecord::Base
  has_enumeration_for :type, :with => AdType
  belongs_to :company
  has_one :image, :as => :parent, :dependent => :destroy
end
