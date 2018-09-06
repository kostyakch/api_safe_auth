module ApiSafeAuth
  class Defender

    attr_reader :params, :token, :timestamp

    def initialize(params = {})
      @params = params
      @token = params[:hash]
      @timestamp = ApiSafeAuth.get_timestamp(params).to_i || 0
    end

    def protect
      raise ApiSafeAuth::InvalidTokenError if token != right_token
      raise ApiSafeAuth::TokenExpiredError if token_expired?
    end

    def self.protect(params)
      self.new(params).protect
    end

    private

    def right_token
      ApiSafeAuth.generate_token(params.symbolize_keys)
    end

    def token_expired?
      (Time.now.to_i - timestamp).abs > ApiSafeAuth.config.token_expiration
    end
    
  end
end