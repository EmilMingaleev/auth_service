RSpec.describe Auth::SaveRefreshToken do
  let(:user_id) { "user-123" }
  let(:ip) { "127.0.0.1" }
  let(:token_pair_id) { SecureRandom.uuid }
  let(:refresh_token_raw) { SecureRandom.urlsafe_base64(64) }
  let(:refresh_token_hashed) { BCrypt::Password.create(refresh_token_raw) }

  subject(:result) do
    described_class.call(
      user_id: user_id,
      refresh_token_raw: refresh_token_raw,
      refresh_token_hashed: refresh_token_hashed,
      ip: ip,
      token_pair_id: token_pair_id
    )
  end

  context "when saving refresh token is successful" do
    it "saves the refresh token and updates context" do
      expect(result).to be_success
      expect(result.refresh_token).to eq(refresh_token_raw)
      expect(result.refresh_token_record).to be_persisted
      expect(result.refresh_token_record.user_id).to eq(user_id)
      expect(result.refresh_token_record.token_pair_id).to eq(token_pair_id)
      expect(result.refresh_token_record.revoked).to be_falsey
    end
  end

  context "when saving refresh token fails" do
    before do
      allow(RefreshToken).to receive(:create!).and_raise(StandardError.new("Database error"))
    end

    it "fails and provides an error message" do
      expect(result).to be_failure
      expect(result.error).to eq("Failed to save refresh token: Database error")
    end
  end
end
