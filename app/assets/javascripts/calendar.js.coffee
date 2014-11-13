$(document).ready ->
  $('#calendar').fullCalendar
    eventStartEditable: true
    defaultView: 'month'
    eventLimit: true
    events: '/events.json'
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