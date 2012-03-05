# -*- encoding : utf-8 -*-
class CreatePartnerSiteStyles < ActiveRecord::Migration
  def self.up
    create_table :partner_site_styles do |t|
      t.integer :partner_id
      t.string :subdomain
      t.string :title
      t.text :header
      t.text :footer
      t.text :stylesheet

      t.timestamps
    end
  end

  def self.down
    drop_table :partner_site_styles
  end
end
