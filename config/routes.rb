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
        post '/auth', to: 'auth#check', as: 'auth'
        get '/me', to: 'users#me', as: 'me'
        put '/me', to: 'users#update', as: 'update_me'
        post '/reactions', to: 'reactions#create', as: 'create_reaction'
        get '/reactions/:uuid', to: 'reactions#show', as: 'get_reaction'
        get '/users/:uuid', to: 'users#show', as: 'user'
        get '/users/:uuid/reactions', to: 'users#reactions', as: 'user_reactions'
      end
    end
  end

  # Neutral root for heat
  get '/', to: 'root#index', as: 'heat'
end
