require 'rails_helper'

#TTD: Test driven development
#Prueba de integracion -> Prueba la app de principio a fin.
#Nombre para el conjunto de pruebas / tipo de pruebas (de integracion -> Request)
RSpec.describe "Posts", type: :request do
    
    #Contexto sin datos en la DB.
    describe "GET /post" do
        before { get '/post' }

        it "should return OK" do
            payload = JSON.parse(response.body)
            expect(payload).not_to be_empty
            expect(response).to have_http_status(200)
        end
    end

    #Contexto con datos en la DB.
    describe "With data in the DB" do
        let(:posts) { create_list(:post, 10, published:true) }
        before { get '/post' }
        it "should return all the published posts"do
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(posts.size)
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /post/{id}" do
        let(:posts) { create(:post) }

        it "should return a post"do
            before { get "/post/#{post.id}" }
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to_eq(post.id)
            expect(response).to have_http_status(200)
        end
    end
end