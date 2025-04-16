module Auth
  class RefreshTokens::DecodeAccessToken
    include Interactor

    def call
      access_token = context.access_token
      begin
        decoded = JWT.decode(
          access_token,
          Rails.application.secret_key_base,
          true,
          { algorithm: "HS512" }
        ).first
        context.user_id = decoded["user_id"]
        context.token_ip = decoded["ip"]
        context.token_pair_id = decoded["token_pair_id"]
      rescue JWT::DecodeError
        context.fail!(error: "Invalid access token")
      end
    end
  end
end
