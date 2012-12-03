# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

getDadosJson = (data) ->
  dados = []
  dados["locais"] = []
  dados["quantidade"] = data.query.count
  for elemento in data.query.results.place
    dados["locais"].push({"id": elemento.woeid, "nome":elemento.name})
    
  dados

# parte continentes
jQuery ->  
  setHtmlDadosContinents = (dados) ->
    $("blockquote#continents p span").html(dados.quantidade)
    
    html_select = ""
    for i in dados.locais
      html_select += "<option value='" + i["id"] + "'>" + i["nome"] + "</option>"
      
    $("blockquote#continents select").append(html_select)
    
  $.ajax  'ajax/get-continets',
    type: 'POST'
    beforeSend  : () ->
    success     : (data, textStatus, jqXHR) ->
      dados = getDadosJson data
      setHtmlDadosContinents dados
    error       : (data, textStatus, jqXHR) ->
      
# parte países
jQuery ->
  setHtmlDadosPais = (dados) ->
    $("blockquote#countries p span").html(dados.quantidade)
    
    html_select = "<option value=''>Selecione um País</option>"
    for i in dados.locais
      html_select += "<option value='" + i["id"] + "'>" + i["nome"] + "</option>"
      
    $("blockquote#countries select").html(html_select)
    
  $("blockquote#continents select").change ->
    id_continet = $(this).val()
    
    if id_continet
      $.ajax  'ajax/get-countries',
        type: 'POST'
        data: {id: id_continet}
        beforeSend  : () ->
        success     : (data, textStatus, jqXHR) ->
          dados = getDadosJson data
          setHtmlDadosPais dados
        complete    : () ->
          $("blockquote#countries").fadeIn(1000)
    else
      $("blockquote#countries, blockquote#states").hide()
      
# parte países
jQuery ->
  setHtmlDadosCidade = (dados) ->
    $("blockquote#states p span").html(dados.quantidade)
    
    html_select = "<option value=''>Selecione uma Cidade</option>"
    for i in dados.locais
      html_select += "<option value='" + i["id"] + "'>" + i["nome"] + "</option>"
      
    $("blockquote#states select").html(html_select)
    
  $("blockquote#countries select").change ->
    id_countries = $(this).val()
    
    if id_countries
      $.ajax  'ajax/get-states',
        type: 'POST'
        data: {id: id_countries}
        beforeSend  : () ->
        success     : (data, textStatus, jqXHR) ->
          dados = getDadosJson data
          setHtmlDadosCidade dados
        complete    : () ->
          $("blockquote#states").fadeIn(1000)
    else
      $("blockquote#states").hide()