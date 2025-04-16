RSpec.describe Auth::RefreshTokens::CheckIpAddress do
  subject(:call_interactor) do
    described_class.call(user_id: user_id, token_ip: token_ip, ip: current_ip)
  end

  let(:user_id) { "user-123" }
  let(:token_ip) { "127.0.0.1" }

  context "when IP address is the same" do
    let(:current_ip) { token_ip }

    it "does not log a warning" do
      expect(Rails.logger).not_to receive(:warn)
      call_interactor
    end
  end

  context "when IP address has changed" do
    let(:current_ip) { "127.1.1.1" }

    it "logs a warning message" do
      expect(Rails.logger).to receive(:warn).with(
        "IP changed for user"
      )
      call_interactor
    end
  end
end
