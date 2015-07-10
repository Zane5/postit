PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'
  #get '/posts', to: 'posts#index'
  #get '/posts/:id', to: 'posts#show'
  #get '/posts/new', to: 'posts#new'
  #pots '/posts', to: 'posts#create'
  #get '/posts/:id/edit', to:'posts#edit'
  #patch '/posts/:id', to: 'posts#update'

  resources :posts, except: [:destroy] do
    member do 
      post :vote
      #get :flag
    end
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
    # GET /posts/archives
    # collection do
    #   get :archives # /posts/archives
    # end

	end
  
  resources :categories, only: [:new, :create, :show]

  resources :users, only: [:show, :create, :edit, :update]

  #resources :categories

  # resources :vote, only: [:create]
  # POST /votes => 'votesController#create'
  #  - needs two pices of information

  # POST /posts/3/vote => 'PostsController#vote'
  # POST /comments/4/vote => 'CommentsController#vote'
  resources :chargers
end