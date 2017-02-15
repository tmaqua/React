Rails.application.routes.draw do

  get 'hello_world', to: 'hello_world#index'
  mount API => '/'

  ## for LandingPage
  root 'welcome#index'
  get 'welcome/index'

end
