RSpec.describe Auth::RefreshTokens::DecodeAccessToken do
  subject(:result) { described_class.call(access_token: token) }

  let(:user_id) { "user-123" }
  let(:ip) { "127.0.0.1" }
  let(:token_pair_id) { SecureRandom.uuid }

  let(:valid_token) do
    JWT.encode(
      {
        user_id: user_id,
        ip: ip,
        token_pair_id: token_pair_id,
        exp: 10.minutes.from_now.to_i
      },
      Rails.application.secret_key_base,
      "HS512"
    )
  end

  context "when access token is valid" do
    let(:token) { valid_token }

    it "decodes the token and sets context values" do
      expect(result).to be_success
      expect(result.user_id).to eq(user_id)
      expect(result.token_ip).to eq(ip)
      expect(result.token_pair_id).to eq(token_pair_id)
    end
  end

  context "when access token is invalid" do
    let(:token) { "not.a.valid.token" }

    it "fails the context" do
      expect(result).to be_failure
      expect(result.error).to eq("Invalid access token")
    end
  end
end
