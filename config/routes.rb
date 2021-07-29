Rails.application.routes.draw do
  #first main page of the site will be the homepage with login information
  resources :sessions, only: [:create, :new, :destroy]
  
  get '/', to: redirect('/homepage');

  post '/login', to: 'session#new'
  get '/timesheet', to: 'session#logged_in'
  get '/logout', to: 'session#destroy'

  get '/homepage', to: 'application#index'
  get '/login', to: 'application#login'
  get '/reset_password', to: 'application#reset_password'
  get '/new_user', to: 'user#new'

  get '/sample', to: 'application#sample'

  get '/new_entry', to: 'application#new_entry'
  get '/edit_post/:id', to: 'application#edit_post'
  
  get '/register', to: 'application#register'
  post '/register', to: 'application#new_user'

  post '/add_entry', to: 'application#add_entry'
  post '/edit_post/:date', to: 'application#update_entry'
  post '/delete_post', to: 'application#destroy'
    #add a route for a given post above

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
