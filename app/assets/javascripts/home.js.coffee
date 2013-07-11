$ ->
  source = new ESHQ('messages/create', {auth_headers: {'X-CSRF-Token': -> $("meta[name='csrf-token']").attr("content")}})
  source.onmessage = (e) ->
    $('#code').append("<div class='msg'>#{e.data}</div>")