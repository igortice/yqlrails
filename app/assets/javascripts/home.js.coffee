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
  
setHtmlForSelect = (obj, dados) ->
  $("p span", obj).html(dados.quantidade)

  html_select = "<option value=''>" + $("select option:first", obj).text() + "</option>"
  for i in dados.locais
    html_select += "<option value='" + i["id"] + "'>" + i["nome"] + "</option>"
    
  $("select", obj).html(html_select)
  
  return;
  
ajaxRequestPost = (url, obj, data_hash) ->
  $.ajax  url,
    type: 'POST'
    data: data_hash
    beforeSend  : () ->
    success     : (data) ->
      dados = getDadosJson(data)
      setHtmlForSelect(obj, dados)
    complete    : () ->
      obj.fadeIn(500)


# parte continentes
jQuery ->
  ajaxRequestPost('ajax/get-continents', $("blockquote#continents"))
      
# parte países
jQuery ->
  $("blockquote#continents select").change ->
    $("blockquote#countries, blockquote#states").hide()
    if id_continet = $(this).val()
      ajaxRequestPost('ajax/get-countries', $("blockquote#countries"), {id: id_continet})
      
# parte estados
jQuery ->
  $("blockquote#countries select").change ->
    $("blockquote#states").hide()
    if id_countries = $(this).val()
      ajaxRequestPost('ajax/get-states', $("blockquote#states"), {id: id_countries})