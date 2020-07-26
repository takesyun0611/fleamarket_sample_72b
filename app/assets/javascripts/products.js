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

    //投稿編集時
    if (window.location.href.match(/\/products\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      //編集ボタンのidを追加
      $('.update-box').each(function(index, box){
        $(box).attr('id', `edit_btn_${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })
      var count = $('.preview-box').length;
      //プレビューが５あるときは、投稿ボックスを消しておく。
      if (count == 5) {
        $('.label-content').hide()
      }
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

        //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す
        if ($(`#product_pictures_attributes_${id}__destroy`)){
          $(`#product_pictures_attributes_${id}__destroy`).prop('checked',false);
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
      //product_pictures_attributes_${id}_content から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();

      //新規登録時と編集時の場合分け

      //新規登録時
      //削除用チェックボックスの有無で判定
      if ($(`#product_pictures_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除
        $(`#product_pictures_attributes_${id}_content`).val("");
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
      } else {

        //投稿編集時
        $(`#product_pictures_attributes_${id}__destroy`).prop('checked', true); //削除ボタンを押すとdeletecheckboxにcheckが入るようにする
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content').show();
        }

        //ラベルのwidth操作
        setLabel();
        if(id < 5){
          $('.label-box').attr({id: `label-box--${id}`,for: `product_pictures_attributes_${id}_content`});
        }
      }
    });

    // 画像の編集
    $(document).on('click', '.update-box', function() {
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      $(`#product_pictures_attributes_${id}_content`).click();
    });

  });
})

//カテゴリ機能(商品編集用)
$(document).on('turbolinks:load', function(){
  $('#category_parent').on('change', function() {
    let parentCategoryEdit = document.getElementById('parent_category').value; //親カテゴリのデータを取得して変数に入れる
    if (parentCategoryEdit != '選択してください'){
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { category_id: parentCategoryEdit },
        dataType: 'json'
      })
      .done(function(children){ //成功した時の処理
        $('.details-category__boxes__select__box__child').remove(); //元々あった子カテゴリを削除
        $('.details-category__boxes__select__box__grandchild').remove(); //元々あった孫カテゴリを削除
        let insertHTML = ''; //insertHTMLを定義して中身にオプションをつける
        children.forEach(function(child){
          insertHTML += appendOption(child); 
        });
        appendCild(insertHTML); //オプション付きのinsertHTMLをappendChildにいれる
                                //上のappendChildで定義された$('details-category__boxes__select__box').append(childSelectHTML);により一番、つまり親カテゴリーの下に差し込まれる
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else {
      $('#category_child').remove();
      $('#category_child').remove();
    }
  });
});

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
});

$(document).on('turbolinks:load', function() {
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

  $(document).ready(function(){
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
  });
});

$(document).on('turbolinks:load', function(){
  $('.showProduct--info__optional__like').on('click', function(e){
    e.preventDefault();
    var like = this.value;
    $.ajax({
      type: 'POST',
      url: '/likes/create',
      data: like,
      dataType: 'json',
      processData: false,
      contentType: false
    })
  });
});