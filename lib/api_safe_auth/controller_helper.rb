module ApiSafeAuth
  module ControllerHelper

    def authorize_request!
      return true if current_user.present?
      ApiSafeAuth.authenticate(params)
    end

  end
end