class Yql
  attr_accessor :url_service, :url_base,:query, :fomart
  def initialize
    @url_base     ||= "http://query.yahooapis.com/v1/public/yql"
    @format       ||= "json"
    @query        ||= "show tables"
    
    @url_service  ||= generate_url_service
  end
  
  def self.get_continents
    yql = Yql.new
    yql.query = "select * from geo.continents"
    @url_service = yql.generate_url_service
    
    JSON.parse(RestClient.get @url_service)
  end
  
  def self.get_countries id_continet
    yql = Yql.new
    yql.query = "select * from geo.countries where place=#{id_continet}"
    @url_service = yql.generate_url_service
    
    JSON.parse(RestClient.get @url_service)
  end
  
  def self.get_states id_countries
    yql = Yql.new
    yql.query = "select * from geo.states where place=#{id_countries}"
    @url_service = yql.generate_url_service
    
    JSON.parse(RestClient.get @url_service)
  end

  def generate_url_service
    URI.escape("#{@url_base}?q=#{@query}&format=#{@format}")
  end

end