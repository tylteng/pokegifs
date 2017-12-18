class PokemonController < ApplicationController

  def show
    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(response.body)

    name = body["name"]
    array_types = body["types"]
    id = body["id"]

    types = []
    array_types.each do |type|
      types << type["type"]["name"]
    end

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&q=#{name}&rating=g")
    body = JSON.parse(res.body)
    url = body["data"].sample["url"]

    render json: { id: id, name: name, types: types, gif: url}
  end

end
