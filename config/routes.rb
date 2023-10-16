Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  get '/health', to: 'health#health'

  #Puedo definir todos los metodos de un CRUD
  resources :posts, only: [:index, :show]
end
