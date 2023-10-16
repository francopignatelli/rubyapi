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
        let!(:posts) { create_list(:post, 10, published: true) }
    
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
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(post.id)
            expect(response).to have_http_status(200)
        end
    end

    describe "POST /posts" do
        let!(:user) { create(:user) }

        it "should create a post" do
            req_payload = {
                post: {
                    title: "Titulo",
                    content: 'content',
                    published: false,
                    user_id: user.id
                }
            }

            #Ref al metodo post de HTTP
            post "/posts", params: req_payload
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to_not be_nil
            expect(response).to have_http_status(:created)
        end

        it "should return error message on invalid post" do
            req_payload = {
                post: {
                    content: 'content',
                    published: false,
                    user_id: user.id
                }
            }

            #Ref al metodo post de HTTP
            post "/posts", params: req_payload
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["error"]).to_not be_empty
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    describe "PUT /posts/{id}" do
        let!(:article) { create(:post) }

        it "should create a post" do
            req_payload = {
                post: {
                    title: "Titulo",
                    content: 'content',
                    published: true,
                    user_id: user.id
                }
            }

            #Ref al metodo post de HTTP
            put "/posts/#{article.id}", params: req_payload
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(article.id)
            expect(response).to have_http_status(:ok)
        end
    end
end