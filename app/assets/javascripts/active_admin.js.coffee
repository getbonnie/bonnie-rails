#= require active_admin/base
#= require activeadmin-sortable
#= require plyr

$(document).ready ->
  Plyr.setup('.player', {
    'controls': [ 'play', 'progress' ]
  })
  return
