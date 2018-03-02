require_relative '../models/comment'
require_relative '../models/post'
require_relative '../database'
require 'json'

lines = File.open("database.rb", "r")

doc = ""
lines.each do |line|
  doc << line
end
lines.close

content = JSON.parse(doc)

posts = content["DB"]
comments = content["COMMENTS"]

p posts
p comments

posts.each_with_index do |post, index|
  Post.create(title: post.title, content: )
end
title: "Mon premier article",
    content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id ratione harum illo, dicta minima rerum quod natus cupiditate voluptatibus rem! Amet reprehenderit voluptatum animi, eligendi quia quos reiciendis veritatis magni.",
    photo: "https://unsplash.it/600?image=0",
    rating:
