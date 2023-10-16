require 'rails_helper'
require 'byebug'
require 'factory_bot_rails'

#TTD: Test driven development
#Prueba de integracion -> Prueba la app de principio a fin.
#Nombre para el conjunto de pruebas / tipo de pruebas (de integracion -> Request)
RSpec.describe "Posts", type: :request do
    
    #Contexto sin datos en la DB.
    describe "GET /posts" do
        before { get '/posts' }

        it "should return OK" do
            payload = JSON.parse(response.body)
            expect(payload).to be_empty
            expect(response).to have_http_status(200)
        end
    end

    #Contexto con datos en la DB.
    describe "With data in the DB" do
    
        let!(:posts) { create_list(:post, 10) }
      
    
        it "should return all the published posts"do
            get '/posts'
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(posts.size)
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /posts/{id}" do
     
    let!(:post) { FactoryBot.create(:post) }

        it "should return a post"do
            get "/posts/#{post.id}"
            payload = JSON.parse(response.body)
            expect(payload).to be_empty
            expect(payload["id"]).to eq(post.id)
            expect(response).to have_http_status(200)
        end
    end
end