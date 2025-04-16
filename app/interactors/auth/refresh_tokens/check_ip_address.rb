module Auth
  class RefreshTokens::CheckIpAddress
    include Interactor

    def call
      if context.token_ip != context.ip
        Rails.logger.warn("IP changed for user")
      end
    end
  end
end
