$(function(){
  function buildHTML(message){
    if ( message.image ) {
      var html =`
      <div class="message" data-message-id=${message.id}>
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
      return html;
      }else{
      var html =`
      <div class="message" data-message-id=${message.id}>
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
      $(".btn").removeAttr("disabled");
    })
  })

  var reloadMessages = function(){
    last_message_id = $('.message:last').data('message-id');
    console.log(last_message_id)
    $.ajax({
      url: 'api/messages',
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done (function(messages){
      if (messages.length !== 0) {
        var insertHTML = '';
        $.each(messages, function(i, message){
          insertHTML += buildHTML(message)
        });
        $('.messages').append(insertHTML);
        $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
      }
    })
    .fail(function(){
      console.log('error');
    })
  };
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
  setInterval(reloadMessages, 7000);
  }
});