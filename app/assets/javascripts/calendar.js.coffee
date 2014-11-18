$(document).ready ->
  bindCalendar('#user_calendar', '/my_calendar.json', true)
  bindCalendar('#public_calendar', '/public_calendar.json', false)
  $('#navigation_submit').bind 'click', (clickEvent, data) -> refreshCalendar(clickEvent, data)

bindCalendar = (elementId, dataPath, editable) ->
  $(elementId).fullCalendar
    eventStartEditable: editable
    defaultView: 'month'
    eventLimit: true
    eventBackgroundColor: '#26990d'
    events: dataPath
    eventClick: (event) ->
      if editable
        location.href = '/events/' + event.id + '/edit'
    eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
      updateEvent(event, delta)

updateEvent = (event, delta) ->
  endsOn = moment(event.ends_on).add(delta.days(), 'd').format('YYYY-MM-DD')
  $.ajax
    url: '/events/' + event.id,
    type: 'PATCH'
    dataType: 'json'
    data:
      event:
        id: event.id
        title: event.title,
        starts_on: event.start.format()
        recurring: event.recurring
        repeats: event.repeats
        ends_on: endsOn

refreshCalendar = (clickEvent, data) ->
  selectedValue = $('#navigation_date').val()
  if selectedValue != ''
    selectedDate = moment(selectedValue)
    $('.calendar').fullCalendar('gotoDate', selectedDate);