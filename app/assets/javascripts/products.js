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









$(document).on('turbolinks:load', function(){
  $(function(){

    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="update-box"  id="edit_btn_${count}">
                        <span>編集</span>
                      </div>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // ラベルのwidth操作
    function setLabel() {
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `product_pictures_attributes_${id}_content`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content').hide();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `product_pictures_attributes_${count}_content`});
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();
      console.log("new")
      //フォームの中身を削除 
      $(`#product_pictures_attributes_${id}_content`).val("");

      //削除時のラベル操作
      var count = $('.preview-box').length;
      //5個めが消されたらラベルを表示
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 5){
        //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
        $('.label-box').attr({id: `label-box--${id}`,for: `product_pictures_attributes_${id}_content`});
      }
    });

    // 画像の編集
    $(document).on('click', '.update-box', function() {
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      $(`#product_pictures_attributes_${id}_content`).click();
    });
  });
})



// 利益、手数料の計算
$(document).on('turbolinks:load', function(){ //turbolinksにより１度リロードしないと発火しないため、turbolinksを無効にする記述を書く
  $('#price_calc').on('input', function(){  //リアルタイムで表示したいのでinputを使う。入力の度にイベントが発火するようにする
    let data = $('#price_calc').val(); //val()でフォームのvalueを取得(数値)
    let profit = Math.round(data * 0.9) //手数料計算を行う。dataに掛けているのが0.9なのは手数料が10%のため
    let fee = (data - profit) //入力した数値から計算結果(profit)を引く。それが手数料となる
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