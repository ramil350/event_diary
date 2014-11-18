$(document).ready ->
  toggleCanRepeat($('#event_recurring'))
  $(document).on('click', '#event_recurring', -> toggleCanRepeat($(this)))

toggleCanRepeat = (checkbox) ->
  repeatsControl = $('#event_repeats')
  endsOnControl = $('#event_ends_on')
  if checkbox.is(':checked')
    repeatsControl.removeAttr('disabled')
    endsOnControl.removeAttr('disabled')
  else
    disableControl(repeatsControl)
    disableControl(endsOnControl)

disableControl = (control) ->
  control.attr('disabled', 'disabled')
  control.val('')