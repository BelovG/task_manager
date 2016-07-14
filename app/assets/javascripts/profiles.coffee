# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("input[id^='state-option']").click ->
#  console.log 1
$(document).ready ->

  $(".next-state-js").on 'ajax:success', (e, data, status, xhr) ->
    $("#state").html(data['state'])
    if data['state'] == "Finished"
      $(this).hide()

  $(".next-state-js").on 'ajax:error', (e, xhr, status, error) ->
    alert error