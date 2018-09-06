require "api_safe_auth/defender"
require "api_safe_auth/controller_helper"

module ApiSafeAuth
  include ActiveSupport::Configurable

  class ConfigurationError < StandardError; end
  class InvalidTokenError < StandardError; end
  class TokenExpiredError < StandardError; end

  configure do |config|
    config.secret_key = ENV["SAFE_AUTH_PRIVATE_KEY"]

    config.token_expiration = 5.minutes

    config.token_generator = proc do |options = {}|
      Digest::MD5.hexdigest([ApiSafeAuth.config.secret_key, ApiSafeAuth.get_token(options), ApiSafeAuth.get_timestamp(options)].join('-'))
    end

    config.defender = ApiSafeAuth::Defender

    config.token_finder = proc {|params| params[:token]}
    config.timestamp_finder = proc {|params| params[:timestamp]}
  end

  def self.generate_token(options = {})
    if ( generator = self.config.token_generator ).blank?
      raise ConfigurationError, 'No generate_token option specified. Check configuration'
    end
    if generator.is_a? Proc
      generator.call options
    elsif generator.respond_to? :generate
      generator.generate options
    else
      raise ConfigurationError, 'generate_token option is incorrect. It must be a proc or must have generate method'
    end
  end

  def self.authenticate(params)
    defender = self.config.defender
    if defender.is_a?(Proc)
      defender.call(params)
    elsif defender.respond_to?(:protect)
      defender.protect(params)
    end
  end

  def self.get_token(params)
    self.config.token_finder.call(params)
  end

  def self.get_timestamp(params)
    self.config.timestamp_finder.call(params)
  end

end

ActiveSupport.on_load(:action_controller) do
  include ApiSafeAuth::ControllerHelper
end
