channel = ->
  window.location.pathname.split("/")[2]

$ ->

  source = new ESHQ("messages/create/#{channel()}", {auth_headers: {'X-CSRF-Token': -> $("meta[name='csrf-token']").attr("content")}})

  reset = new ESHQ("messages/create/#{channel()}/reset", {auth_headers: {'X-CSRF-Token': -> $("meta[name='csrf-token']").attr("content")}})

  source.onmessage = (e) ->
    $('#code').append("<div class='msg'>#{e.data}</div>")
  reset.onmessage = (e) ->
    $('#code').html("")


  $('select').on "change", ->
    console.log $(this).val()
    window.location = "/" + $(this).val()