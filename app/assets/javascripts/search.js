$(document).on('DOMContentLoaded turbolinks:render', function() {
  function AppendCategorySearch(category, child) {
    let html1 = `
      <select id="category_${child}" name="q[category_id]"><option value="">選択してください</option>
    `;

    let html2 = `
    `;

    $.each(category, function(index, value){
      html2 += `
      <option value="${value.id}">${value.name}</option>
      `;
    })

    let html3 = `
      </select>
    `

    $("#category").append(html1+html2+html3);
  }

  function categoryList() {
    var selectParentSearch = document.getElementById('category_parent_search');
    selectParentSearch.onchange = function(){
      if(this.value != ""){
        var input = this.value;
        $.ajax({
          type: 'GET',
          url: '/products/searchChild',
          data: { id: input },
          dataType: 'json'
        })
        .done(function(children) {
          $("#category_child_search").remove();
          $("#category_grandchild_search").remove();
          AppendCategorySearch(children,"child_search");
          var selectParent = document.getElementById('category_child_search');
          selectParent.onchange = function(){
            if(this.value != ""){
              var input = this.value;
              $.ajax({
                type: 'GET',
                url: '/products/searchChild',
                data: { id: input },
                dataType: 'json'
              })
              .done(function(children) {
                $("#category_grandchild_search").remove();
                AppendCategorySearch(children,"grandchild_search");
              })
            }
          }
        })
      }
      else
      {
        $("#category_child_search").remove();
        $("#category_grandchild_search").remove();
      }
    }
  }

  categoryList();

  function ResetSearchForm() {
    let html = `
    <div class="search-extend--content">
    <div class="search-extend--content__label">
    <label for="q_keyword">キーワード</label>
    </div>
    <input placeholder="例）値下げ" type="search" name="q[name_cont]" id="q_name_cont">
    </div>
    <div class="search-extend--content" id="category">
    <div class="search-extend--content__label">
    <label for="q_category">カテゴリを選択する</label>
    </div>
    <select class="category_parent_search" id="category_parent_search" name="q[category_id]"><option value="">選択してください</option>
    <option value="1">レディース</option>
    <option value="2">メンズ</option>
    <option value="3">ベビー・キッズ</option>
    <option value="4">インテリア・住まい・小物</option>
    <option value="5">本・音楽・ゲーム</option>
    <option value="6">おもちゃ・ホビー・グッズ</option>
    <option value="7">コスメ・香水・美容</option>
    <option value="8">家電・スマホ・カメラ</option>
    <option value="9">スポーツ・レジャー</option>
    <option value="10">ハンドメイド</option>
    <option value="11">チケット</option>
    <option value="12">自動車・オートバイ</option>
    <option value="13">その他</option></select>
    </div>
    <div class="search-extend--content">
    <div class="search-extend--content__label">
    <label for="q_price">価格</label>
    </div>
    <input placeholder="¥ Min" type="number" name="q[price_gteq]" id="q_price_gteq">
    ~
    <input placeholder="¥ Max" type="number" name="q[price_lteq]" id="q_price_lteq">
    </div>
    <div class="search-extend--content">
    <div class="search-extend--content__label">
    <label for="q_status">商品の状態</label>
    </div>
    <select name="q[status_id_eq]" id="q_status_id_eq"><option value="">選択してください</option>
    <option value="1">新品、未使用</option>
    <option value="2">未使用に近い</option>
    <option value="3">目立った傷や汚れなし</option>
    <option value="4">やや傷や汚れあり</option>
    <option value="5">傷や汚れあり</option>
    <option value="6">全体的に状態が悪い</option></select>
    </div>
    <div class="search-extend--content">
    <div class="search-extend--content__label">
    <label for="q_delivery_fee">配送料の負担</label>
    </div>
    <select name="q[delivery_fee_id_eq]" id="q_delivery_fee_id_eq"><option value="">選択してください</option>
    <option value="1">送料込み（出品者負担）</option>
    <option value="2">着払い（購入者負担）</option></select>
    </div>
    <div class="search-extend--content">
    <div class="search-extend--content__label">
    <label for="q_sold_out">販売状況</label>
    </div>
    <select name="q[sold_out_eq]" id="q_sold_out_eq"><option value="">指定なし</option>
    <option value="0">販売中</option>
    <option value="1">売り切れ</option></select>
    </div>
    `
    $(".search-extend--contents").append(html);
  }

  $(".search-extend--buttons__clear").on("click", function() {
    $(".search-extend--content").remove()
    ResetSearchForm();
    categoryList()
  });

  $('#productSearch').on('submit', function(e){
    $('#productSearch').off('submit');
    if($("#category_grandchild_search").val() == "") {
      $("#category_grandchild_search").remove();
    };
    if($("#category_child_search").val() == "") {
      $("#category_child_search").remove();
    };
    $('#productSearch').submit();
  });

  var selectParent = document.getElementById('category_child_search');
  selectParent.onchange = function(){
    if(this.value != ""){
      var input = this.value;
      $.ajax({
        type: 'GET',
        url: '/products/searchChild',
        data: { id: input },
        dataType: 'json'
      })
      .done(function(children) {
        $("#category_grandchild_search").remove();
        AppendCategorySearch(children,"grandchild_search");
      })
    }
  }
});