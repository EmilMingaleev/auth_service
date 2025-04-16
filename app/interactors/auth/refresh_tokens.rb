module Auth
  class RefreshTokens
    include Interactor::Organizer

    organize Auth::RefreshTokens::DecodeAccessToken,
             Auth::RefreshTokens::CheckIpAddress,
             Auth::RefreshTokens::ValidateRefreshToken,
             Auth::RefreshTokens::RevokeOldRefreshToken,
             Auth::RefreshTokens::GenerateNewTokens
  end
end
