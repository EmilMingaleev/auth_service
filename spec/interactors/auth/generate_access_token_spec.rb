RSpec.describe Auth::GenerateAccessToken do
  subject(:result) { described_class.call(context) }

  let(:context) do
    Interactor::Context.new(
      user_id: "user-123",
      ip: "127.0.0.1",
      token_pair_id: SecureRandom.uuid
    )
  end

  context "when context is valid" do
    it "generates a valid JWT access token" do
      expect(result).to be_success
      expect(result.access_token).to be_a(String)

      payload, _ = JWT.decode(
        result.access_token,
        Rails.application.secret_key_base,
        true,
        algorithm: "HS512"
      )

      expect(payload["user_id"]).to eq(context.user_id)
      expect(payload["ip"]).to eq(context.ip)
      expect(payload["token_pair_id"]).to eq(context.token_pair_id)
    end
  end

  context "when an error occurs during encoding" do
    before do
      allow(JWT).to receive(:encode).and_raise(StandardError)
    end

    it "fails and sets error message" do
      expect(result).to be_failure
      expect(result.error).to eq("Failed to generate access token")
    end
  end
end
