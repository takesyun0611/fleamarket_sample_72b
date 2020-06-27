$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="product[pictures_attributes][${index}][content]"
                    id="product_pictures_attributes_${index}_content"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();


  $('#picture-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#picture-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#picture-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#picture-box').append(buildFileField(fileIndex[0]));
  });
});

$(function(){
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