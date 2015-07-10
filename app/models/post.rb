class Post < ActiveRecord::Base
	#include VoteableSimonzheng9000Apr
	include Voteable
	include Sluggable

	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	#has_many :votes, as: :voteable
	# attr_accessible :title, :url, :description

	#before_save :generate_slug!

	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true

	sluggable_column :title

end  