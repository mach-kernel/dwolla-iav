$(document).ready ->
  $('#dwolla-iav-button').click ->
    $('#dwolla-iav-button').fadeOut()
    $('#iav-alert').fadeIn()
    console.log 'click'
    dwolla.configure('uat')
    dwolla.iav.start 'dwolla-iav', $('#dwolla-iav-token').text().trim(), (err, fs) ->
      window.location.replace('/finish_funding/' + fs._links['funding-source'].href.split('/').pop())
      return

  return