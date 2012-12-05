class AjaxController < ApplicationController
  def getContinents
    Rails.cache.write('continentes', Yql.get_continents) unless Rails.cache.exist? 'continentes'

    render :json => Rails.cache.read('continentes')
  end

  def getCountries
    continents_id = params[:id]
    Rails.cache.write(continents_id, Yql.get_countries(continents_id.to_i)) unless Rails.cache.exist? continents_id

    render :json => Rails.cache.read(continents_id)
  end

  def getStates
    countries_id = params[:id]
    Rails.cache.write(countries_id, Yql.get_states(countries_id.to_i)) unless Rails.cache.exist? countries_id

    render :json => Rails.cache.read(countries_id)
  end
end