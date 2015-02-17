Rails.application.routes.draw do
  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root :to => redirect('/login')
  get '/register' => 'register#new'
  get '/login' => 'login#index'
  get '/logout' => 'login#destroy'
  get '/key' => 'users#destroy'
  get '/delete/:id', to: 'users#destroy'
  get '/api/creator', to: 'creator#show'
  resources :users, only: [:show, :destroy]

  #get '/api' => 'api_event#index'

  namespace :api do
    resources :event
    resources :events_tag
    resources :tag
    resources :creator
  end



  post '/users/:id', to: 'users#create'
  post '/users'   => 'register#create'
  post '/login'   => 'login#create'

  # Felsidorna
#  match '/404', to: 'errors#file_not_found', via: :all
#  match '/422', to: 'errors#unprocessable', via: :all
#  match '/500', to: 'errors#internal_server_error', via: :all

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
