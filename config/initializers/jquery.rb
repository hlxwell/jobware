ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery => ['jquery', 'rails']
Rails.application.config.action_view.javascript_expansions[:defaults] = ['jquery', 'rails']
