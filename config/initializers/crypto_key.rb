# -*- encoding : utf-8 -*-
require 'openssl'
require 'base64'

module Crypto

  # Crypto.create_keys
  # @priv_key = Crypto::Key.from_file('rsa_key')
  # @pub_key =  Crypto::Key.from_file('rsa_key.pub')
  #
  # @secret = @pub_key.encrypt("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
  # redirect_to "/page/aboutus?key=#{CGI::escape @secret.gsub(/\s/, "")}"
  #
  # @value = @priv_key.decrypt CGI::unescape(params[:key])

  def self.create_keys(priv = "rsa_key", pub = "#{priv}.pub", bits = 1024)
    private_key = OpenSSL::PKey::RSA.new(bits)
    File.open(priv, "w+") { |fp| fp << private_key.to_s }
    File.open(pub,  "w+") { |fp| fp << private_key.public_key.to_s }
    private_key
  end

  class Key
    def initialize(data)
      @public = (data =~ /^-----BEGIN (RSA|DSA) PRIVATE KEY-----$/).nil?
      @key = OpenSSL::PKey::RSA.new(data)
    end

    def self.from_file(filename)
      self.new File.read( filename )
    end

    def encrypt(text)
      Base64.encode64(@key.send("#{key_type}_encrypt", text))
    end

    def decrypt(text)
      @key.send("#{key_type}_decrypt", Base64.decode64(text))
    end

    def private?()
      !@public
    end

    def public?()
      @public
    end

    def key_type
      @public ? :public : :private
    end
  end
end
