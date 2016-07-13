# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("input[id^='state-option']").click ->
#  console.log 1
$(document).ready ->
  $(".state-js").click ->
    data = this.dataset
    $.ajax
      url: "/tasks/#{data.taskId}"
      type: "PUT"
      data: task: {state: data.taskState}
      dataType: 'json'
      success: (res) ->
        console.log res
      error: (res) ->
        console.log res

