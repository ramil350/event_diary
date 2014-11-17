$(document).ready ->
  bindCalendar('#user_calendar', '/my_calendar.json', true)
  bindCalendar('#public_calendar', '/public_calendar.json', false)

bindCalendar = (elementId, dataPath, editable) ->
  $(elementId).fullCalendar
    eventStartEditable: editable
    defaultView: 'month'
    eventLimit: true
    eventBackgroundColor: '#26990d'
    events: dataPath
    eventClick: (event) ->
      location.href = '/events/' + event.id + '/edit'
    eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
      updateEvent(event)

updateEvent = (event) ->
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