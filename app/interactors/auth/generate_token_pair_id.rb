module Auth
  class GenerateTokenPairId
    include Interactor

    def call
      context.token_pair_id = SecureRandom.uuid
    end
  end
end
