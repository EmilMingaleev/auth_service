RSpec.describe Auth::RefreshTokens::GenerateNewTokens do
  subject(:context) { described_class.call(user_id: user_id, ip: ip) }

  let(:user_id) { "user-123" }
  let(:ip) { "121.1.1.1" }

  before do
    allow(SecureRandom).to receive(:uuid).and_return("test-pair-id")
    allow(SecureRandom).to receive(:urlsafe_base64).and_return("raw-refresh-token")
  end

  it "generates a new access token and refresh token" do
    expect(context).to be_success

    decoded_token = JWT.decode(
      context.access_token,
      Rails.application.secret_key_base,
      true,
      algorithm: "HS512"
    ).first

    aggregate_failures "validating access token payload" do
      expect(decoded_token["user_id"]).to eq(user_id)
      expect(decoded_token["ip"]).to eq(ip)
      expect(decoded_token["token_pair_id"]).to eq("test-pair-id")
    end

    expect(context.refresh_token).to eq("raw-refresh-token")

    refresh_record = context.refresh_record

    aggregate_failures "validating refresh record" do
      expect(refresh_record).to be_persisted
      expect(refresh_record.user_id).to eq(user_id)
      expect(refresh_record.token_pair_id).to eq("test-pair-id")
      expect(refresh_record.ip_address).to eq(ip)
      expect(refresh_record.revoked).to eq(false)
      expect(BCrypt::Password.new(refresh_record.token_hash)).to eq("raw-refresh-token")
    end
  end
end
