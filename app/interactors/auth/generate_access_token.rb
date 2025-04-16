module Auth
  class GenerateAccessToken
    include Interactor

    def call
      context.access_token = JWT.encode(
        {
          user_id: context.user_id,
          ip: context.ip,
          token_pair_id: context.token_pair_id,
          exp: 10.minutes.from_now.to_i
        },
        Rails.application.secret_key_base,
        "HS512"
      )
    rescue StandardError => e
      context.fail!(error: "Failed to generate access token")
    end
  end
end
