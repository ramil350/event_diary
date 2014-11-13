$(document).ready ->
  toggleCanRepeat($('#event_recurring'))
  $(document).on('click', '#event_recurring', -> toggleCanRepeat($(this)))

toggleCanRepeat = (checkbox) ->
  repeatsControl = $('#event_repeats')
  if checkbox.is(':checked')
    repeatsControl.removeAttr('disabled')
  else
    repeatsControl.attr('disabled', 'disabled')
    repeatsControl.val('')