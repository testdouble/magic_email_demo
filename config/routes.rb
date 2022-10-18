Rails.application.routes.draw do
  match "login_emails/authenticate", to: "login_emails#authenticate", via: [:get, :post]
  resource :login_email

  resources :numbers

  root "numbers#index"
end
