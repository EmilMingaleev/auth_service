Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/token", to: "auth#token"
      put "auth/refresh", to: "auth#refresh"
    end
  end
end
