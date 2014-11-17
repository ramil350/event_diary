$(document).ready ->
  bindCalendar('#user_calendar', '/my_calendar.json')
  bindCalendar('#public_calendar', '/public_calendar.json')

bindCalendar = (elementId, dataPath) ->
  $(elementId).fullCalendar
    eventStartEditable: true
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