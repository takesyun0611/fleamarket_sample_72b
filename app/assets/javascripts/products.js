$(function(){
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#img-file').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `<img src="${src}" width="114" height="80">`
      //image_box__container要素の前にhtmlを差し込む
      $('#image-box__container').before(html);
    }
    fileReader.readAsDataURL(file);
  });
});


$(document).on('turbolinks:load', function(){ //turbolinksにより１度リロードしないと発火しないため、turbolinksを無効にする記述を書く
  $('#price_calc').on('input', function(){  //リアルタイムで表示したいのでinputを使う。入力の度にイベントが発火するようにする
    var data = $('#price_calc').val(); //val()でフォームのvalueを取得(数値)
    var profit = Math.round(data * 0.9) //手数料計算を行う。dataに掛けているのが0.9なのは手数料が10%のため
    var fee = (data - profit) //入力した数値から計算結果(profit)を引く。それが手数料となる
    $('.price-boxes__fee__value').html(fee) //手数料の表示。html()は追加ではなく、上書きをするための記述。入力値が変わる度に表示も変わるようにする
    $('.price-boxes__fee__value').prepend('¥') //手数料の前に¥マークを付ける記述
    $('.price-boxes__profit__value').html(profit)
    $('.price-boxes__profit__value').prepend('¥')
    if(data < 300) { //入力された値が300未満であれば計算されない
      $('.price-boxes__fee__value').html('-');
      $('.price-boxes__profit__value').html('-'); 
    } else if(data > 10000000) { //入力された値が10,000,000以上であれば計算されない
      $('.price-boxes__fee__value').html('-');
      $('.price-boxes__profit__value').html('-'); 
    }
  })
})