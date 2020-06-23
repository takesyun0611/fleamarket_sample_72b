$(function(){
  $('#price_calc').on('input', function(){
    var data = $('#price_calc').val();
    var profit = Math.round(data * 0.9)
    var fee = (data - profit)
    $('.actual-fee').html(fee)
    $('.actual-fee').prepend('¥')
    $('.actual-profit').html(profit)
    $('.actual-profit').prepend('¥')
    $('#price_calc').var(data)
    if(profit == '') {
      $('.actual-profit').html('');
      $('.actual-fee').html('');
    }
  })
})