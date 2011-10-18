$(document).ready () ->
  $('#create_test').click () ->
    create_deffered = $.rr.create 'questions', {text:'js question'}
    create_deffered.done () -> alert 'done!'
    create_deffered.done () -> location.reload true
    return false
  $('#create_test_error').rr_create 'questions', {text:''}
  $('.delete').rr_delete()
