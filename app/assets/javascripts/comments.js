$(function() {
  function buildHTML(comment){
    var html = `
    <div class="showProduct--comment__comments__box">
      <div class="showProduct--comment__comments__box__userName">
        ${comment.user_name}
      </div>
      <div class="showProduct--comment__comments__box__content">
        ${comment.content}
      </div>
      <div class="showProduct--comment__comments__box__date">
        ${comment.date}
      </div>
    </div>
    `
    return html;
  }

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.showProduct--comment__comments').append(html);
      $('#new_comment').reset();
    })
  });
});