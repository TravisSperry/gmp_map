jQuery ->
  width = 960
  height = 960
  projection = d3.geo.mercator().scale((width + 1) / 2 / Math.PI).translate([
    width / 2
    height / 2
  ]).precision(.1)
  path = d3.geo.path().projection(projection)
  graticule = d3.geo.graticule()

  pusher = new Pusher 'f8ea3976aaec34c6ad26',
    encrypted: true

  channel = pusher.subscribe 'Subscriber_Channel'
  channel.bind 'New_Subscriber', (response) ->
    xy = projection(response.data)
    svg.append("circle").attr
      cx: xy[0],
      cy: xy[1],
      r: 2,
      fill: 'red'

  svg = d3.select('body').append('svg').attr('width', width).attr('height', height)
  svg.append('path').datum(graticule).attr('class', 'graticule').attr 'd', path
  d3.json 'us', (error, world) ->
    if error
      throw error
    svg.insert('path', '.graticule').datum(topojson.feature(world, world.objects.land)).attr('class', 'land').attr 'd', path
    svg.insert('path', '.graticule').datum(topojson.mesh(world, world.objects.countries, (a, b) ->
      a != b
    )).attr('class', 'boundary').attr 'd', path
    return
  d3.select(self.frameElement).style 'height', height + 'px'

  coordinates = $('#map_canvas').data('coordinates')

  for coordinate in coordinates
    xy = projection(coordinate)
    svg.append("circle").attr
      cx: xy[0],
      cy: xy[1],
      r: 2,
      fill: '#e2b506'
