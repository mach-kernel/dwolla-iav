$(document).ready(function() {

    $('#dwolla-iav-button').click(function() {
        $('#dwolla-iav-button').fadeOut();
        $('#iav-alert').fadeIn();

        dwolla.configure('uat');

        return dwolla.iav.start(
            'dwolla-iav',
            $('#dwolla-iav-token').text().trim(),
            function(err, fs) {
                window.location.replace(
                    '/finish_funding/' + fs._links['funding-source'].href.split('/').pop()
                );
            });
    });

});