Rails.application.routes.draw do

  mount API => '/'

  ## for LandingPage
  root 'welcome#index'
  get 'welcome/index'

end
