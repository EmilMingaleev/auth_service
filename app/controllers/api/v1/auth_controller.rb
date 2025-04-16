module Api
  module V1
    class AuthController < ApplicationController
      def token
        result = ::Auth::IssueTokens.call(user_id: params[:user_id], ip: request.remote_ip)

        if result.success?
          render json: TokenSerializer.new(result), status: :ok
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end

      def refresh
        result = ::Auth::RefreshTokens.call(
          access_token: params[:access],
          refresh_token: params[:refresh],
          ip: request.remote_ip
        )

        if result.success?
          render json: TokenSerializer.new(result), status: :ok
        else
          render json: { error: result.error }, status: :unauthorized
        end
      end
    end
  end
end
