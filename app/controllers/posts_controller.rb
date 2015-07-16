class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only:[:edit, :update]
  # 1. set up instance variable for action
  # 2. redirect based on some condition

  def index
  	#render 'index' # :index
  	#render 'posts/index'
  	@posts = Post.limit(Post::PER_PAGE).offset(params[:offset])   ####.sort_by{|x| x.total_votes}.reverse
    @pages = (Post.all.size.to_f / Post::PER_PAGE).ceil

    respond_to do |format|
      format.html
      format.xml { render xml: @posts }
    end
  end

  def show #; end
  	#binding.pry
  	#@post = Post.find(params[:id])
  	#render :show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json {render json: @post }
      format.xml { render xml: @post }
    end
  end

  def new
    @post = Post.new   
  end

  def create
    #binding.pry

    @post = Post.new(post_params)
    #binding.pry
    #@post.creator = User.first # TODO: change once we have authentication
    @post.creator = current_user
    
    if @post.save
      flash[:notice] = "You post was created."
      redirect_to posts_path
    else #validation error
      render :new
    end
  end

  def edit;  end

  def update
    #@post = Post.find(params[:id])
    #binding.pry
    
    if @post.update(post_params)
      flash[:notice] = "the post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do #{redirect_to :back, notice: "Your vote was counted"}
        if vote.valid?
          flash[:notice] = "You vote was counted."
        else
          flash[:error] = "You can only vote for <strong>that</strong> once.".html_safe
        end
        redirect_to :back
      end
      format.js #{ render json: @post}
    end
  end
  
  private

  def post_params
    # if user.admin?
      #params.require(:post).permit!
    # else
    params.require(:post).permit(:title, :url, :description,category_ids: [])
    # end
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin? )
  end
end
