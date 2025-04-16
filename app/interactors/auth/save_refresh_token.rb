module Auth
  class SaveRefreshToken
    include Interactor

    def call
      context.refresh_token_record = RefreshToken.create!(
        user_id: context.user_id,
        token_hash: context.refresh_token_hashed,
        ip_address: context.ip,
        token_pair_id: context.token_pair_id,
        revoked: false
      )

      context.refresh_token = context.refresh_token_raw
    rescue StandardError => e
      context.fail!(error: "Failed to save refresh token: #{e.message}")
    end
  end
end
