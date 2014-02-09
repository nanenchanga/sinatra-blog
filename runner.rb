require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///blog.sqlite3"

class Post < ActiveRecord::Base

end

get '/' do
  @posts = Post.all
  erb :index
end

get '/posts/new' do
  @post = Post.new

  erb :new_post
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :index_post
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit_post
end

post '/posts/delete' do
  @post = Post.find(params[:id])
  @post.destroy

  redirect "/posts"

end

post '/posts/create' do
  @post = Post.new

  @post.title = params["post-title"]
  @post.description = params["post-description"]

  @post.save!

  redirect "/posts/#{@post.id}"

end



post '/posts/:id/update' do
  @post = Post.find(params[:id])

  @post.title = params["post-title"]
  @post.description = params["post-description"]

  @post.save!

  redirect "/posts/#{@post.id}"
end


get '/posts/:id/destroy' do
  @post = Post.find(params[:id])
  @post.destroy

  redirect '/'
end


