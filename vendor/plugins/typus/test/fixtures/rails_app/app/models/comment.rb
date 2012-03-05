# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  validates_presence_of :name, :email, :body
  belongs_to :post

end
