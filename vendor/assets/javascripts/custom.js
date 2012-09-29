$(function() {
  $('a#link_comment').click(function(event){
    event.preventDefault();
    $('div#div_comment_box').toggle();
  });
}); 