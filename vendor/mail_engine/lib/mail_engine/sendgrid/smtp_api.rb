require 'json'

# "X-SMTPAPI" => '{"category": "itjob", "to": ["hlxwell@gmail.com"], "filters": {"footer": {"settings": {"enable":1,"text/plain": "Thank you for your business"}}}}'
module MailEngine
  module Sendgrid
    class SmtpApi
      def initialize()
        @data = {}
      end

      def add_to(to)
        @data['to'] ||= []
        @data['to'] += to.kind_of?(Array) ? to : [to]
      end

      def add_sub_val(var, val)
        @data['sub'] ||= {}
        @data['sub'][var] = val.instance_of?(Array) ? var : [var]
      end

      def set_unique_args(val)
        @data['unique_args'] = val if val.instance_of?(Hash)
      end

      def set_category(cat)
        @data['category'] = cat
      end

      def add_filter_setting(fltr, setting, val)
        @data['filters'] ||= {}
        @data['filters'][fltr] ||= {}
        @data['filters'][fltr]['settings'] ||= {}
        @data['filters'][fltr]['settings'][setting] = val
      end

      def to_s
        'X-SMTPAPI: %s' % self.to_json.gsub(/(.{1,72})( +|$\n?)|(.{1,72})/,"\\1\\3\n")
      end

      def to_json
        JSON.generate(@data).gsub(/(["\]}])([,:])(["\[{])/, '\\1\\2 \\3')
      end

      def to_hash
        {'X-SMTPAPI' => self.to_json.gsub(/(.{1,72})( +|$\n?)|(.{1,72})/,"\\1\\3\n")}
      end
    end
  end
end