$(function() {
  function AppendCategory(category, child) {
    let html1 = `
    <div class="details-category__boxes__select">
      <div class="details-category__boxes__select__box">
        <select id="category_${child}" name="product[category_id]"><option value="">選択してください</option>
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
      </div>
    </div>
    `

    $(".details-category__boxes").append(html1+html2+html3);
  }

  var selectParent = document.getElementById('category_parent');
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
        $("#category_child").remove();
        $("#category_grandchild").remove();
        AppendCategory(children,"child");
        var selectParent = document.getElementById('category_child');
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
              $("#category_grandchild").remove();
              AppendCategory(children,"grandchild");
            })
          }
        }
      })
    }
    else
    {
      $("#category_child").remove();
      $("#category_grandchild").remove();
    }
  }
});