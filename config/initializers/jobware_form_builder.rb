class JobwareFormBuilder < ActionView::Helpers::FormBuilder
  alias_method :origin_select, :select

  # <%= f.text_field :contact_name, :label => "联系人", :class => "text w600" %>
  %w[text_field text_area password_field check_box cktext_area file_field].each do |method_name|
    define_method(method_name) do |field_name, *args|
      options = merge_to_options args.last, :class => "text"
      tag_mark = method_name == "check_box" ? :span : :div
      other_classes = options[:type] == "agree_term" ? "right" : ""

      @template.content_tag(:div, :class => "form-row #{other_classes}") {
         @template.content_tag(tag_mark, :class => "form-property") {
           label(field_name, options[:label]) +
           # append errors
           unless object.nil?
             errors = object.errors[field_name.to_sym]
             if method_name == "file_field"
               errors = object.errors[field_name.to_sym]
               errors += object.errors["#{field_name}_file_size".to_sym]
             end
             @template.content_tag(:span, errors.is_a?(Array) ? errors.first : errors, :class => "field_error") if errors
           end
         } +
         @template.content_tag(tag_mark, :class => "form-value") {
           super(field_name, options) +
           (options[:required] == true ? @template.content_tag(:span, "（必填）", :class => "helper") : "") +
           @template.content_tag(:div, "", :class => 'clearer') +
           (options[:hint].present? ? @template.content_tag(tag_mark, options[:hint], :class => "helper") : "")
         }
      } +
      @template.content_tag(:div, "", :class => 'clearer')
    end
  end

  def select(field_name, choices, *args)
    options = args.last
    @template.content_tag(:div, :class => "form-row") do
       @template.content_tag(:div, :class => "form-property") {
          label(field_name, options[:label]) +
          unless object.nil?
            errors = object.errors[field_name.to_sym]
            @template.content_tag(:span, errors.is_a?(Array) ? errors.first : errors, :class => "field_error") if errors
          end
       } +
       (@template.content_tag(:div, :class => "form-value") {
         super(field_name, choices, *args) +
         (options[:required] == true ? @template.content_tag(:span, "（必填）", :class => "helper") : "") +
         @template.content_tag(:div, "", :class => 'clearer') +
         (options[:hint].present? ? @template.content_tag(:div, options[:hint], :class => "helper") : "")
       })
    end +
    (@template.content_tag(:div, "", :class => 'clearer'))
  end

  def submit(text = nil, *args)
    options = merge_to_options args.last, :class => "button"

    @template.content_tag(:div, :class => "form-row-submit") do
      super(text, options) +
      @template.content_tag(:div, "", :class => 'clearer')
    end
  end


  ###### province and city selector
  def city_select(province_field, city_field = nil, options = {})
    @template.content_tag(:script) do
      "$(function(){
        $('##{@object.class.to_s.downcase}_#{province_field}').val('#{@object.send(province_field.to_sym)}').change();
        $('##{@object.class.to_s.downcase}_#{city_field}').val('#{@object.send(city_field.to_sym)}');
      })"
    end +

    @template.content_tag(:div, :class => "form-row city_selector") do
      #### show label in error css when anyone of column has error.
      if @object.present?
        if @object.errors[city_field.to_sym]
          @template.content_tag(:div, :class => "form-property") {
            label(city_field, options[:label]) +
            unless object.nil?
              errors = object.errors[city_field.to_sym]
              @template.content_tag(:span, errors.is_a?(Array) ? errors.first : errors, :class => "field_error") if errors
            end
          }
        else @object.errors[province_field.to_sym]
          @template.content_tag(:div, :class => "form-property") {
            label(province_field, options[:label]) +
            unless object.nil?
              errors = object.errors[province_field.to_sym]
              @template.content_tag(:span, errors.is_a?(Array) ? errors.first : errors, :class => "field_error") if errors
            end
          }
        end
      end +
      (@template.content_tag(:div, :class => "form-value") {
       origin_select(province_field, [], {}, {:class => "province"}) +
       (city_field.present? ? origin_select(city_field, [], {}, {:class => "city"}) : "") +
       (options[:required] == true ? @template.content_tag(:span, "（必填）", :class => "helper") : "") +
       (options[:hint].present? ? @template.content_tag(:div, options[:hint], :class => "helper") : "")
      })
    end +
    (@template.content_tag(:div, "", :class => 'clearer'))
  end

  #### help add fields to resume builder form.
  def link_to_remove_fields(name, *args)
    options = merge_to_options args.last, :class => "right large"

    if object.new_record?
      link_to_function(name, "remove_fields(this)", options)
    else
      link_to_function(name, "hide_fields(this)", options) +
      hidden_field(:_destroy)
    end
  end

  def button_to_add_fields(name, association, *args)
    options = merge_to_options args.last, :class => "button right"
    new_object = @object.class.reflect_on_association(association).klass.new
    fields = fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      @template.render("#{options[:namespace_dir]}/#{association}/form", :f => builder)
    end
    button_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", options)
  end

  private

  # add default class for element
  def merge_to_options(merge_to_options, option)
    (merge_to_options||{}).reverse_merge!(option)
  end

  def get_error_message(method, text = "")
    unless object.nil?
      errors = object.errors[method.to_sym]
      text += @template.content_tag(:span, errors.is_a?(Array) ? errors.first : errors) if errors
    end
    text
  end
end