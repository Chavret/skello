require "sinatra"
require "sinatra/reloader" if development?
require_relative "database"

get "/" do
  @database = DB
end

configure :development do
  set :database, {adapter: 'postgresql',
    encoding: 'unicode',
    database: 'posts_and_comments',
    pool: 2,
    username: 'geoffrey',
    password: 'ababab'}
end

configure :production do
  set :database, {adapter: 'postgresql',
    encoding: 'unicode',
    database: 'posts_and_comments',
    pool: 2,
    username: 'geoffrey',
    password: 'ababab'}
end
