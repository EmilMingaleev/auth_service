module Auth
  class GenerateAccessToken
    include Interactor
    delegate :user_id, :ip, :token_pair_id, to: :context

    def call
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
    rescue StandardError => e
      context.fail!(error: "Failed to generate access token")
    end
  end
end
