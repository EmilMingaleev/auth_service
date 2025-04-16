RSpec.describe Auth::RefreshTokens::ValidateRefreshToken do
  subject(:context) do
    described_class.call(user_id: user_id, refresh_token: token_to_validate)
  end

  let(:user_id) { "user-123" }
  let(:raw_token) { "super-secret-refresh-token" }
  let(:hashed_token) { BCrypt::Password.create(raw_token) }

  let!(:refresh_record) do
    RefreshToken.create!(
      user_id: user_id,
      token_hash: hashed_token,
      ip_address: "127.0.0.1",
      token_pair_id: SecureRandom.uuid,
      revoked: false
    )
  end

  context "when refresh token is valid" do
    let(:token_to_validate) { raw_token }

    it "succeeds and assigns the refresh record" do
      expect(context).to be_success
      expect(context.refresh_record).to eq(refresh_record)
    end
  end

  context "when refresh token is invalid" do
    let(:token_to_validate) { "wrong-token" }

    it "fails with an error" do
      expect(context).to be_failure
      expect(context.error).to eq("Invalid refresh token")
    end
  end

  context "when refresh token was revoked" do
    let(:token_to_validate) { raw_token }

    before { refresh_record.update!(revoked: true) }

    it "fails with an error" do
      expect(context).to be_failure
      expect(context.error).to eq("Invalid refresh token")
    end
  end
end
