$(document).ready ->
  $('#dwolla-iav-button').click ->
    console.log 'click'
    dwolla.configure('uat')
    dwolla.iav.start 'dwolla-iav', $('#dwolla-iav-token').text().trim(), (err, res) ->
      console.log($('#dwolla-iav-token').text())
      console.log(err)
      console.log(res)
      return

  return