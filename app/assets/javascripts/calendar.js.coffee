$(document).ready ->
  $('#calendar').fullCalendar
    eventStartEditable: true
    defaultView: 'month'
    eventLimit: true
    events: '/events.json'

