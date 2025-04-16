RSpec.describe Auth::IssueTokens do
  subject(:result) { described_class.call(user_id: user_id, ip: ip) }

  let(:user_id) { "user-123" }
  let(:ip) { "127.0.0.1" }

  it "successfully issues tokens and sets values in context" do
    expect(result).to be_success
    expect(result.access_token).to be_present
    expect(result.refresh_token).to be_present

    payload, _ = JWT.decode(
      result.access_token,
      Rails.application.secret_key_base,
      true,
      algorithm: "HS512"
    )

    expect(payload["user_id"]).to eq(user_id)
    expect(payload["ip"]).to eq(ip)
    expect(payload["token_pair_id"]).to eq(result.token_pair_id)

    expect(result.refresh_token_record).to be_a(RefreshToken)
    expect(result.refresh_token_record.token_pair_id).to eq(result.token_pair_id)
  end
end
