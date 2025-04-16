RSpec.describe Auth::GenerateTokenPairId do
  it "sets a token_pair_id in the context" do
    result = described_class.call

    expect(result).to be_success
    expect(result.token_pair_id).to be_present
  end
end
