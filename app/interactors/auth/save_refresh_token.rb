module Auth
  class SaveRefreshToken
    include Interactor
    delegate :refresh_token_hashed, :refresh_token_raw, :user_id, :ip, :token_pair_id, to: :context

    def call
      context.refresh_token_record = RefreshToken.create!(
        user_id: user_id,
        token_hash: refresh_token_hashed,
        ip_address: ip,
        token_pair_id: token_pair_id,
        revoked: false
      )

      context.refresh_token = refresh_token_raw
    rescue StandardError => e
      context.fail!(error: "Failed to save refresh token: #{e.message}")
    end
  end
end
