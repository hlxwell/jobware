# -*- encoding : utf-8 -*-
class ChangeMailTemplateLayoutDefaultValue < ActiveRecord::Migration
  def self.up
    change_column_default :mail_templates, :layout, "none"
  end

  def self.down
    change_column_default :mail_templates, :layout, nil
  end
end
