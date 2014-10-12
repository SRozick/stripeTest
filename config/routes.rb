Rails.application.routes.draw do

  root 'static#home'

  get 'static/home'

  get 'static/about'

  resources :widgets

end
