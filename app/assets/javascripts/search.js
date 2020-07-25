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

  $(".search-extend--buttons__clear").on("click", function() {
    $("#q_name_cont").val('');
    $("#productSearch")[0].reset();
    $("#category_child_search").remove();
    $("#category_grandchild_search").remove();
  });
});