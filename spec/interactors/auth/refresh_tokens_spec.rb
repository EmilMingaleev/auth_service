RSpec.describe Auth::RefreshTokens do
  subject(:result) do
    described_class.call(
      access_token: access_token,
      refresh_token: refresh_token_raw,
      ip: ip
    )
  end

  let(:user_id) { "user-123" }
  let(:ip) { "127.0.0.1" }
  let(:token_pair_id) { SecureRandom.uuid }

  let(:access_token_payload) do
    {
      user_id: user_id,
      ip: ip,
      token_pair_id: token_pair_id,
      exp: 10.minutes.from_now.to_i
    }
  end

  let(:access_token) do
    JWT.encode(access_token_payload, Rails.application.secret_key_base, "HS512")
  end

  let(:refresh_token_raw) { SecureRandom.urlsafe_base64(64) }
  let(:refresh_token_hashed) { BCrypt::Password.create(refresh_token_raw) }

  let!(:refresh_record) do
    RefreshToken.create!(
      user_id: user_id,
      token_hash: refresh_token_hashed,
      ip_address: ip,
      token_pair_id: token_pair_id,
      revoked: false
    )
  end

  it "refreshes tokens successfully" do
    expect(result).to be_success

    expect(result.access_token).to be_present
    expect(result.refresh_token).to be_present

    expect(refresh_record.reload.revoked).to eq(true)

    expect(result.refresh_record).to be_present
    expect(result.refresh_record.token_pair_id).not_to eq(token_pair_id)
  end
end
