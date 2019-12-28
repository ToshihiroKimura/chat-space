$(function(){
  function buildHTML(message){
    if (message.image) {
      var html = `<div class="message">
        <div class="message__user-name">
          ${message.user_name}
        </div>
        <div class="message__time">
          ${message.created_at}
        </div>
        <div class="message__content">
          <p>
            ${message.text}
          </p>
            <image src =${message.image}>
        </div>
      </div>`
    } else {
      var html = `<div class="message">
        <div class="message__user-name">
          ${message.user_name}
        </div>
        <div class="message__time">
          ${message.created_at}
        </div>
        <div class="message__content">
          <p>
            ${message.text}
          </p>
        </div>
      </div>`
    }
    return html;
  }

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html)
      $('form')[0].reset();
      $(".btn").removeAttr("disabled");
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
    })
    .fail(function(){
      alert('メッセージ送信に失敗しました');
      $('#message_text').val('')
      $(".btn").removeAttr("disabled");
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
    })
  })
});