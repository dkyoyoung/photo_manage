Rails.application.routes.draw do
  root   'photo_manage#index'
  get    'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/photo_manage',   to: 'photo_manage#index'
  get    '/photo_manage/new',   to: 'photo_manage#new'
  post   '/photo_manage',   to: 'photo_manage#create'
end
