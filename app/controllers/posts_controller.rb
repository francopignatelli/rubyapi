class PostsController < ApplicationController
    #Metodo para listar
    #GET /post
    def index
        @posts = Post.where(published: true)
        render json: @posts, status: :ok
    end

    #Metodo para mostrar el detalle de un post
    #GET /post/{id}
    def show
        @post = Post.find(params[:id])
        render json: @post, status: :ok
    end
end