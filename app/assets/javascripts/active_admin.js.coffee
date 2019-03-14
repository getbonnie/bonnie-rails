#= require active_admin/base
#= require activeadmin-sortable

$(document).ready ->
  Plyr.setup('.player', {
    'controls': [ 'play', 'progress' ]
  })
  return
