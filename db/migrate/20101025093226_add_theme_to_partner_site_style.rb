class AddThemeToPartnerSiteStyle < ActiveRecord::Migration
  def self.up
    add_column :partner_site_styles, :theme, :string
  end

  def self.down
    remove_column :partner_site_styles, :theme
  end
end
