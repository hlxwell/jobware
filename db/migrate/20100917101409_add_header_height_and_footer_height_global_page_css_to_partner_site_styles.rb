# -*- encoding : utf-8 -*-
class AddHeaderHeightAndFooterHeightGlobalPageCssToPartnerSiteStyles < ActiveRecord::Migration
  def self.up
    add_column :partner_site_styles, :header_height, :string
    add_column :partner_site_styles, :footer_height, :string
    add_column :partner_site_styles, :global_css, :text
  end

  def self.down
    remove_column :partner_site_styles, :global_css
    remove_column :partner_site_styles, :footer_height
    remove_column :partner_site_styles, :header_height
  end
end
