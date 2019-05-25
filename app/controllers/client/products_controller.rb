class Client::ProductsController < ApplicationController
  def index 
    @products = HTTP.get("http://localhost:3000/api/products/") 
    render 'index.html.erb'
  end 

  def new 
    render 'new.html.erb'
  end 

  def create 
    client_params = {
                    name: params[:name],
                    price: params[:price],
                    description: params[:description],
                    quantity: params[:quantity]
                    }

    response = HTTP.post(
                          "http://localhost:3000/api/products",
                          form: client_params
                        )

    @product = response.parse  
    redirect_to "/client/products/#{@product['id']}"
  end 

  def show 
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
    @product = response.parse 
    render 'show.html.erb'
  end 

  def edit 
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
    @product = response.parse 

    render 'edit.html.erb'
  end 

  def update
    client_params = {
                    name: params[:name],
                    price: params[:price],
                    quantity: params[:quantity],
                    ingredients: params[:ingredients],
                    description: params[:description]
                    }

    response = HTTP.patch(
                          "http://localhost:3000/api/products/#{params[:id]}",
                          form: client_params
                          )

    redirect_to "/client/products/#{params[:id]}"
  end 
end

