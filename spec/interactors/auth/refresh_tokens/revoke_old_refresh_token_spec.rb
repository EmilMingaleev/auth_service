RSpec.describe Auth::RefreshTokens::RevokeOldRefreshToken do
  subject(:context) { described_class.call(refresh_record: refresh_record) }

  let(:refresh_record) do
    RefreshToken.create!(
      user_id: "user-123",
      token_hash: BCrypt::Password.create("some_token"),
      ip_address: "127.0.0.1",
      token_pair_id: SecureRandom.uuid,
      revoked: false
    )
  end

  it "revokes the refresh token" do
    expect { context }.to change { refresh_record.reload.revoked }.from(false).to(true)
  end
end
