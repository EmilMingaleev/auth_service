module Auth
  class PrepareRefreshToken
    include Interactor

    def call
      context.refresh_token_raw = SecureRandom.urlsafe_base64(64)

      context.refresh_token_hashed = BCrypt::Password.create(context.refresh_token_raw)
    end
  end
end
