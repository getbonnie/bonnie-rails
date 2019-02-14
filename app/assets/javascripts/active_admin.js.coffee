#= require active_admin/base

$(document).ready ->
  Plyr.setup('.player', {
    'controls': [ 'play', 'progress' ]
  })
  return
