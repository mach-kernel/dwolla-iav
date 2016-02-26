var inject;

inject = function(key) {
  var r;
  r = void 0;
  r = $('.highlight').html().replace(new RegExp('"' + key + '".*?".*?".*?".*?".*?".*?".*?', 'igm'), '"' + key + '"</span><span class="p">:</span> <span class="s2">"' + $('#customer_' + key).val() + '"');
  $('.highlight').html(r);
};

$(document).ready(function() {
  $('#customer_firstName').on({
    keyup: function() {
      inject('firstName');
    }
  });
  $('#customer_lastName').on({
    keyup: function() {
      inject('lastName');
    }
  });
  $('#customer_email').on({
    keyup: function() {
      inject('email');
    }
  });
  $('#customer_ipAddress').on({
    keyup: function() {
      inject('ipAddress');
    }
  });
});