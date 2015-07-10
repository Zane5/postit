class ChargersController < ApplicationController
  def index
  	#render 'index' # :index
  	#render 'posts/index'
  	#@posts = Post.all.sort_by{|x| x.total_votes}.reverse
  	@chargers = Charger.all
  end
end