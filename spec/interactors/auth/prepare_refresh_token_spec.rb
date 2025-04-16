RSpec.describe Auth::PrepareRefreshToken do
  it "generates raw and hashed refresh token" do
    result = described_class.call

    expect(result).to be_success
    expect(result.refresh_token_raw).to be_present
    expect(result.refresh_token_hashed).to be_present

    expect(
      BCrypt::Password.new(result.refresh_token_hashed)
    ).to eq(result.refresh_token_raw)
  end
end
