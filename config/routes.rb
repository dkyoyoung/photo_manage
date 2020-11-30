Rails.application.routes.draw do
  root   'photo_manage#index'
  get    'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/photo_manage',   to: 'photo_manage#index'
  get    '/photo_manage/new',   to: 'photo_manage#new'
  get    '/photo_manage/ouath',   to: 'photo_manage#oauth'
  get    '/oauth/callback',   to: 'photo_manage#callback'
  post   '/photo_manage',   to: 'photo_manage#create'
  get    '/photo_manage/tweets',   to: 'photo_manage#tweets'
end
