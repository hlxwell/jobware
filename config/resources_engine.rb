set :admin_prefix       => 'ITJob.fm Admin',
    :admin_name         => '<img src="/common/images/header_for_admin.gif" style="margin-top:-35px;height:70px;"/>',
    :logout_path        => '/users/sign_out',
    :dashboard_template => '/admin/dashboard',
    :dashboard_layout   => 'layouts/resources/tis'


resource_alias :translation, ::Qor::ResourcesEngine::Translation
resource_alias :diff, ::Qor::Publish::Diff

resource_list :job, :company, :user

meta :created_at, :format => :short
meta [:birthday, :support_until,:sale_until, :new_until, :publish_from, :publish_to, :start_date, :end_date], :format => :date, :type => :calendar
meta :content, {:type => :rich_text_editor, :exclude => ["FONT_COLOR", "BACKGROUND_COLOR", "FONT_FACE", "INDENT", "OUTDENT", "JUSTIFY_RIGHT", "STRIKE_THROUGH"], :html_safe => true}

write_attrs :exclude => [:id, :created_at, :updated_at, :deleted_at]

mount(:at => '/qor_admin') do
  theme :tis
end