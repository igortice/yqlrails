class HomeController < ApplicationController
  def index
    url = URI.escape('http://query.yahooapis.com/v1/public/yql?q=select * from geo.states where place="Brasil"&format=json')
    @estados_brasil = JSON.parse(RestClient.get url)
  end
end
