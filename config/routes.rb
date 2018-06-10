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

  constraints(->(req) { req.host.match(/^(dev\.)(getbonnie|pew)\.(here|cool|com)$/) }) do
    namespace :landing, path: '/' do
      get '/', to: 'welcome#root', as: :root
    end
  end

  constraints(->(req) { req.host.match(/^(api|api-dev)?\.(getbonnie|pew)\.(here|cool|io)$/) }) do
    namespace :api, path: '/' do
      namespace :v1 do
        post '/auth', to: 'auth#check', as: :auth
        post '/likes/:type/:uuid', to: 'likes#create', as: :like
        get  '/me', to: 'users#me', as: :me
        put  '/me', to: 'users#update', as: :update_me
        get  '/pews', to: 'pews#index', as: :pews
        post '/pews', to: 'pews#create', as: :create_pew
        get  '/pews/:uuid', to: 'pews#show', as: :get_pew
        get  '/pews/:uuid/comments', to: 'comments#index', as: :comments
        post '/pews/:uuid/comments', to: 'comments#create', as: :comment
        post '/plays/:type/:uuid', to: 'plays#create', as: :play
        get  '/users/:uuid', to: 'users#show', as: :user
        get  '/users/:uuid/pews', to: 'users#pews', as: :user_pews
      end
    end
  end

  # Neutral root for heat
  get '/', to: 'root#index', as: :heat
end
