require 'rails_helper'
 
 RSpec.describe "Post", type: :request do
   describe "GET /posts/:id" do
 
     before do
       @post = Post.create( :title => "foo", :content => "bar")

     end
 
     it "should return Post JSON" do
       get "/posts/#{@post.id}.json"
 
       data = {
         "id" => @post.id,
         "title" => @post.title
       }
 
       expect(response).to have_http_status(200)
       expect( JSON.parse(response.body) ).to eq(data)
     end
 
   end
 end