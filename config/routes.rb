Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'customers/:id/rank_info', to: 'customers#rank_info'
  get 'orders/customer_orders/:id', to: 'orders#customer_orders'
  post '/orders', to: 'orders#create'
end
