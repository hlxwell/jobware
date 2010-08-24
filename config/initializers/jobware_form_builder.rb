class JobwareFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field text_area password_field check_box].each do |method_name|
    define_method(method_name) do |field_name, *args|
      options = merge_to_options args.last, :class => "text"
      tag_mark = method_name == "check_box" ? :span : :div

      @template.content_tag(:div, :class => "form-row") do
         (@template.content_tag(tag_mark, label(field_name, options[:label]), :class => "form-property")) +

         (@template.content_tag(tag_mark, :class => "form-value") {
           super(field_name, options) +
           (options[:required] == true ? @template.content_tag(:span, "（必填）", :class => "helper") : "") +
           (options[:hint].present? ? @template.content_tag(tag_mark, options[:hint], :class => "helper") : "")
         }) +

         (@template.content_tag(:div, "", :class => 'clearer'))
      end
    end
  end
  
  def select(field_name, choices, *args)
    options = args.last
    @template.content_tag(:div, :class => "form-row") do
       (@template.content_tag(:div, label(field_name, options[:label]), :class => "form-property")) +

       (@template.content_tag(:div, :class => "form-value") {
         super(field_name, choices, *args) +
         (options[:required] == true ? @template.content_tag(:span, "（必填）", :class => "helper") : "") +
         (options[:hint].present? ? @template.content_tag(:div, options[:hint], :class => "helper") : "")
       }) +

       (@template.content_tag(:div, "", :class => 'clearer'))
    end
  end

  # def separator(new_section_name, options = {})
  #   return options[:html] if options[:html].present?
  #   raw "</fieldset><fieldset class='#{options[:class]}'><legend>#{new_section_name}</legend>"
  # end
      
  def submit(text = nil, *args)
    options = merge_to_options args.last, :class => "button"

    @template.content_tag(:div, :class => "form-row form-row-submit") do
      super(text, options) +
      @template.content_tag(:div, "", :class => 'clearer')
    end
  end

  private
  # add default class for element
  def merge_to_options(merge_to_options, option)
    (merge_to_options||{}).merge!(option) { |key, v1, v2| v1 }
  end
end