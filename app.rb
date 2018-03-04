require "sinatra"
require 'sinatra/base'
require "sinatra/reloader" if development?
require 'sinatra/activerecord'
require 'active_record'
require 'net/http'
require 'uri'
require_relative "database"
require_relative "models/comment"
require_relative "models/post"
require_relative "services/create_posts_and_comments"

configure do
  set :public_folder, File.expand_path('../public', __FILE__)
  set :views        , File.expand_path('../views', __FILE__)
  set :root         , File.dirname(__FILE__)
end

get '/' do
  @database = DB
  @comments = COMMENTS
  CreatePostsAndComments.new(posts: @database, comments: @comments).perform
  @posts = Post.includes(:comments).order("created_at").reverse_order.all
  erb :layout
end

get '/post/:id/upvote' do
  @post = Post.find_by(id: params['id'])
  rate = @post.rate.to_i + 1
  @post.update_column(:rate, rate)
  @posts = Post.includes(:comments).order("created_at").reverse_order.all
  erb :layout
end

post '/post/:id/comments/create' do
  @post = Post.find_by(id: params['id'])
  @comment = Comment.create(post_id: @post.id, text: params['input'])
  @posts = Post.includes(:comments).order("created_at").reverse_order.all
  erb :layout
end

get '/post/:id/random_image' do
  @post = Post.find_by(id: params['id'])
  photo_sizes = ["600", "400", "300", "100"]
  photo_sizes.each do |photo|
    if @post.photo.include?("/" + photo)
      @post.update(photo: @post.photo.gsub("/#{photo}", "/" + photo_sizes.shuffle.first))
      break
    end
  end
  @posts = Post.includes(:comments).order("created_at").reverse_order.all
  erb :layout
end


configure :development do
  set :database, {adapter: 'postgresql',
    encoding: 'unicode',
    database: 'posts_and_comments',
    pool: 2,
    host: 'localhost'}
end

configure :production do
  set :database, {adapter: 'postgresql',
    encoding: 'unicode',
    database: 'posts_and_comments',
    pool: 2,
    host: 'localhost'}
end

helpers do
  def img(name)
    "<img src='images/#{name}' alt='#{name}' />"
  end
end
