$(document).ready ->
  $('#dwolla-iav-button').click ->
    console.log 'click'
    dwolla.config.dwollaUrl = 'https://uat.dwolla.com/'
    dwolla.iav.start 'dwolla-iav', $('#dwolla-iav-token').text(), (err, res) ->
      console.log($('#dwolla-iav-token').text())
      console.log(err)
      console.log(res)
      return

  return