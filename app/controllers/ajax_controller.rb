class AjaxController < ApplicationController
  def getContinets
    render :json => Yql.get_continents
  end
  
  def getCountries
    render :json => Yql.get_countries(params[:id].to_i)
  end
  
  def getStates
    render :json => Yql.get_states(params[:id].to_i)
  end
end