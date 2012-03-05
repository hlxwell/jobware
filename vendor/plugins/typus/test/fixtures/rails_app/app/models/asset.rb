# -*- encoding : utf-8 -*-
class Asset < ActiveRecord::Base

  belongs_to :resource, :polymorphic => true

end
