class StaticController < ApplicationController

  def home

  end

  def index

    response = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{rand(1..700)}/")
    @result = JSON.parse(response.body)
    
  end


end
