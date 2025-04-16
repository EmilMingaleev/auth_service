module Auth
  class PrepareRefreshToken
    include Interactor
    delegate :refresh_token_raw, :refresh_token_hashed, to: :context

    def call
      context.refresh_token_raw = SecureRandom.urlsafe_base64(64)
      context.refresh_token_hashed = BCrypt::Password.create(refresh_token_raw)
    end
  end
end
