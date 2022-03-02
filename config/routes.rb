Rails.application.routes.draw do
  root to: 'plans#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    "plans",          to: "plans#index"
  get    "plans/new",      to: "plans#new"
  post   "plans",          to: "plans#create"
  # NB: The `show` route needs to be *after* `new` route.
  get    "plans/:id",      to: "plans#show"
  get    "plans/:id/edit", to: "plans#edit"
  patch  "plans/:id",      to: "plans#update"
  delete "plans/:id",      to: "plans#destroy"

  resources :plans, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :ingredients, only: [:index, :show]
    resources :recipes, only: [:index, :show]
    resources :recipe_tags, only: [:index, :show]
    resources :tags, only: [:index, :show]
  end
end
