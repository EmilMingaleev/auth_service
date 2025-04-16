module Auth
  class RefreshTokens::ValidateRefreshToken
    include Interactor

    def call
      refresh_token = context.refresh_token
      user_id = context.user_id

      refresh_record = RefreshToken
                         .where(user_id: user_id, revoked: false)
                         .order(created_at: :desc)
                         .first

      unless refresh_record && BCrypt::Password.new(refresh_record.token_hash) == refresh_token
        context.fail!(error: "Invalid refresh token")
      end
      context.refresh_record = refresh_record
    end
  end
end
