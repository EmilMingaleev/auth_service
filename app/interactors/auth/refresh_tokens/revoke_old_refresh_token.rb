module Auth
  class RefreshTokens::RevokeOldRefreshToken
    include Interactor

    def call
      context.refresh_record.update!(revoked: true)
    end
  end
end
