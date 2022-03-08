Rails.application.routes.draw do
  root to: 'pages#home'

  resources :plans, only: [:index] do
    collection do
      post :remove
      post :add
      get :refresh # Routes pour le bouton Randomiser (ne pas supprimer)
      get :export # Routes pour bouton Export PDF (ne pas supprimer)
    end
  end
end