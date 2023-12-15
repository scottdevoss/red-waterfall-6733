class SearchController < ApplicationController
  def index
    @nation = params[:nation]
    response = Faraday.get("https://last-airbender-api.fly.dev/api/v1/characters?affiliation=#{@nation}")
    @data = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    
  end
end