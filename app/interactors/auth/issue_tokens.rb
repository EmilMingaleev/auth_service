module Auth
  class IssueTokens
    include Interactor::Organizer

    organize GenerateTokenPairId,
             PrepareRefreshToken,
             SaveRefreshToken,
             GenerateAccessToken
  end
end
