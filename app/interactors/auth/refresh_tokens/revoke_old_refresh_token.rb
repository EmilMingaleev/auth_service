module Auth
  class RefreshTokens::RevokeOldRefreshToken
    include Interactor
    delegate :refresh_record, to: :context

    def call
      refresh_record.update!(revoked: true)
    end
  end
end
