Rails.application.routes.draw do
  unless Rails.env.test?
    constraints(->(req) { req.host.match(/(dev\.)?bobonn\.(here|io)$/) }) do
      devise_for :admin_users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)
    end
  end

  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  constraints(->(req) { req.host.match(/^(dev\.)getbonnie\.(here|com)$/) }) do
    namespace :landing, path: '/' do
      get :root, path: '/', to: 'welcome#root'
    end
  end

  constraints(->(req) { req.host.match(/^(api|api-dev)?\.getbonnie\.(here|io)$/) }) do
    namespace :api, path: '/' do
      namespace :v1 do
        post :auth, path: '/auth', to: 'auth#check'
        get :me, path: '/me', to: 'users#me'
        put :me, path: '/me', to: 'users#update'
        resources :reactions, only: %i[create show]
        resources :users, only: %i[show]
      end
    end
  end

  # Neutral root for heat
  get :heat, path: '/', to: 'root#index'
end
