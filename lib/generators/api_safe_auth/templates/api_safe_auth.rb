ApiSafeAuth.configure do |config|
  config.secret_key = ENV["SAFE_AUTH_PRIVATE_KEY"]

  # config.token_expiration = 5.minutes

  # config.token_generator = proc do |options = {}|
  #   Digest::MD5.hexdigest([ApiSafeAuth.config.secret_key, ApiSafeAuth.get_token(options), ApiSafeAuth.get_token(options)].join('-'))
  # end

  # config.defender = ApiSafeAuth::Defender

  # config.token_finder = proc {|params| params[:token]}
  # config.timestamp_finder = proc {|params| params[:timestamp]}
end