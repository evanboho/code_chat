$ ->
  source = new ESHQ('events/events', {auth_headers: {'X-CSRF-Token': -> $("meta[name='csrf-token']").attr("content")}})
  source.addEventListener 'message', (e) ->
    $('#code').append("<div class='msg'>#{e.data}</div>")