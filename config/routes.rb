Rails.application.routes.draw do
  unless Rails.env.test?
    constraints(->(req) { req.host.match(/(bo|bo-dev)?\.piou\.(here|cool)$/) }) do
      devise_for :admin_users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)
    end
  end

  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  constraints(->(req) { req.host.match(/^(dev\.)?pew\.(here|cool)$/) }) do
    namespace :landing, path: '/' do
      get '/', to: 'welcome#root', as: :root
    end
  end

  constraints(->(req) { req.host.match(/^(api|api-dev)?\.(pew|piou)\.(here|cool)$/) }) do
    namespace :api, path: '/' do
      namespace :v1 do
        post   '/auth', to: 'auth#check'
        post   '/follows/:uuid', to: 'follows#create'
        delete '/follows/:uuid', to: 'follows#delete'
        get    '/hashtags', to: 'hashtags#index'
        post   '/likes/:type/:uuid', to: 'likes#create'
        delete '/likes/:type/:uuid', to: 'likes#delete'
        get    '/me', to: 'users#me'
        put    '/me', to: 'users#update'
        put    '/me/activate', to: 'users#activate'
        put    '/me/suspend', to: 'users#suspend'
        get    '/pews', to: 'pews#index'
        post   '/pews', to: 'pews#create'
        get    '/pews/:uuid', to: 'pews#show'
        delete '/pews/:uuid', to: 'pews#delete'
        get    '/pews/:uuid/comments', to: 'comments#index'
        post   '/pews/:uuid/comments', to: 'comments#create'
        delete '/pews/:uuid/comments/:comment_uuid', to: 'comments#delete'

        # Subscriptions
        delete '/subscriptions/pew/:uuid', to: 'subscriptions#unfollow_pew'
        delete '/subscriptions/comment/:uuid', to: 'subscriptions#unfollow_comment'

        post   '/plays/:type/:uuid', to: 'plays#create'
        get    '/users/:uuid', to: 'users#show'
        get    '/users/:uuid/pews', to: 'users#pews'
        get    '/users/:uuid/followers', to: 'users#followers'
        get    '/users/:uuid/following', to: 'users#following'
        get    '/name_available', to: 'users#name_available'
        get    '/notifications', to: 'notifications#index'
        get    '/notifications/count', to: 'notifications#count'
        put    '/notifications/seen', to: 'notifications#seen'
        put    '/notifications/clicked/:uuid', to: 'notifications#clicked'
        post   '/flags', to: 'flags#create'
      end
    end
  end

  # Neutral root for heat
  get '/', to: 'root#index', as: :heat
end
