module Auth
  class RefreshTokens::GenerateNewTokens
    include Interactor
    delegate :user_id, :ip, :token_pair_id, to: :context

    def call
      context.token_pair_id = SecureRandom.uuid

      context.access_token = JWT.encode(
        {
          user_id: user_id,
          ip: ip,
          token_pair_id: token_pair_id,
          exp: 10.minutes.from_now.to_i
        },
        Rails.application.secret_key_base,
        "HS512"
      )

      new_refresh_token_raw = SecureRandom.urlsafe_base64(64)
      new_refresh_token_hashed = BCrypt::Password.create(new_refresh_token_raw)

      context.refresh_record = RefreshToken.create!(
        user_id: user_id,
        token_hash: new_refresh_token_hashed,
        ip_address: ip,
        token_pair_id: token_pair_id,
        revoked: false
      )
      context.refresh_token = new_refresh_token_raw
    end
  end
end
