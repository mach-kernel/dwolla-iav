inject = (key) ->
  r = undefined
  r = $('.highlight').html().replace(new RegExp('"' + key + '".*?".*?".*?".*?".*?".*?".*?', 'igm'), '"' + key + '"</span><span class="p">:</span> <span class="s2">"' + $('#customer_' + key).val() + '"')
  $('.highlight').html r
  return

$(document).ready ->
  $('#customer_firstName').on keyup: ->
    inject 'firstName'
    return
  $('#customer_lastName').on keyup: ->
    inject 'lastName'
    return
  $('#customer_email').on keyup: ->
    inject 'email'
    return
  $('#customer_ipAddress').on keyup: ->
    inject 'ipAddress'
    return
  return