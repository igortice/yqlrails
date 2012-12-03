# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  dadosContinents = (data) ->
    dados = []
    dados["locais"] = []
    dados["quantidade"] = data.query.count
    for elemento in data.query.results.place
      dados["locais"].push({"id": elemento.woeid, "nome":elemento.name})
      
    dados
    
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
      dados = dadosContinents data
      setHtmlDadosContinents dados
    error       : (data, textStatus, jqXHR) ->
