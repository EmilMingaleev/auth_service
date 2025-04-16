module Auth
  class RefreshTokens::CheckIpAddress
    include Interactor
    delegate :token_ip, :ip, to: :context

    def call
      if token_ip != ip
        Rails.logger.warn("IP changed for user")
      end
    end
  end
end
