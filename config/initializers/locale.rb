# -*- encoding : utf-8 -*-
# in config/initializers/locale.rb # tell the I18n library where to find your translations 
I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.yml')] 
# set default locale to something other than :en 
I18n.default_locale = "zh-CN"
