# NewDataNotifier
require 'action_mailer'

class NewDataNotifier < ActionMailer::Base
  self.mailer_name = 'new_dat_notifier'
  self.append_view_path "#{File.dirname(__FILE__)}/views"

  class << self
    def default_recipients=(recipients)
      @@recipients = recipients
    end

    def default_recipients
      @@recipients ||= []
    end

    def be_monitored_models=(models)
      @@models = models
    end

    def be_monitored_models
      @@models ||= []
    end
    
    def sender_address=(address)
      @@sender_address = address
    end
    
    def sender_address
      @@sender_address ||= %("New Data Notifier" <newdata.notifier@example.com>)
    end

    def default_options
      {
        :sender_address => sender_address,
        :recipients => default_recipients,
        :subject => "[New Data Notification]"
      }
    end
  end

  def notification(data_hash)
    @data_hash = data_hash
    options = self.class.default_options
    mail(:to => options[:recipients], :from => options[:sender_address], :subject => options[:subject]) do |format|
      format.text { render "new_data_notifier/notification" }
    end
  end

  protected

  helper_method :object_name
  def object_name(obj)
    if obj.respond_to?(:title) and obj.try(:title).present?
      obj.title
    elsif obj.respond_to?(:name) and obj.try(:name).present?
      obj.name
    else
      "#{key}##{obj.id}"
    end
  end

end