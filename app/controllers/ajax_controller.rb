class AjaxController < ApplicationController
  def getContinets
    render :json => Yql.get_continents
  end
end