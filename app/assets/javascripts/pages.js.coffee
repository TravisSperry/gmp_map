jQuery ->
  width = 1500
  height = 800
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
      fill: 'red',


  svg = d3.select('#map_canvas').append('svg').attr("preserveAspectRatio", "xMinYMin meet")
   .attr("viewBox", "0 0 1500 960")
   .classed("svg-content-responsive", true);
  svg.append('path').datum(graticule).attr('class', 'graticule').attr 'd', path
  d3.json 'world_data', (error, world) ->
    if error
      throw error
    svg.insert('path', '.graticule')
       .datum(topojson
       .feature(world, world.objects.land)).attr('class', 'land').attr 'd', path
    svg.insert('path', '.graticule').datum(topojson.mesh(world, world.objects.countries, (a, b) ->
      a != b
    )).attr('class', 'boundary').attr 'd', path
    return
  d3.select(self.frameElement).style 'height', height + 'px'

  coordinates = $('#map_canvas').data('coordinates')

  if coordinates
    for coordinate in coordinates
      xy = projection(coordinate)
      svg.append("circle").attr
        cx: xy[0],
        cy: xy[1],
        r: 2,
        fill: '#333366',
        stroke-width: 2
        stroke: "white"

  # Ireland and Great Britain Map
  svg1 = d3.select('#irl-gbr-canvas').append('svg').attr('width', width).attr('height', height)
  d3.json 'irl_gbr_data', (error, features) ->
    console.log features
    svg1.append("path")
      .datum(topojson.feature(features[0], features[0].geometry.objects.subunits))
      .attr("d", d3.geo.path().projection(d3.geo.mercator()))
