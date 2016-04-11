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

  channel = pusher.subscribe 'test_channel'
  channel.bind 'my_event', (data) ->
    alert data.message

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

  coordinates = [[-93.167, 44.9555], [-96.6712, 33.0362], [-96.1333, 19.2], [-6.2597, 53.3478], [-79.8458, 43.1958], [-122.1479, 47.5527], [-112.3975, 42.9061], [-77.2866, 38.7851], [-104.8515, 39.4439], [-79.3872, 43.6425], [-105.4648, 40.4555], [-3.7026, 40.4165], [-122.2471, 37.5331], [-121.2574, 44.0744], [-114.1148, 51.1047], [-97.2517, 32.9346], [-87.9208, 43.148], [-9.1333, 38.7167], [-79.8549, 32.8229], [-0.0833, 51.45], [105.0, 35.0], [-73.9981, 40.7267], [-6.2597, 53.3478], [-74.2579, 40.4169], [-83.1615, 40.0989], [-80.3853, 27.5921], [-76.1958, 40.6895], [-79.3853, 43.702], [-121.9414, 37.0264], [-70.8578, 42.5653], [-118.7457, 55.1834], [-122.8085, 45.2391], [-74.0468, 40.7209], [-117.2549, 47.7464], [-84.9054, 39.8381], [-75.5446, 38.351], [-66.0616, 18.4208], [-89.4087, 40.8133], [-71.4352, 42.3233], [-75.7306, 39.7151], [-82.9104, 42.3276], [-86.2651, 39.8512], [-111.8906, 33.6119], [126.98, 37.57], [-79.9579, 40.5725], [-79.4633, 43.6605], [-95.5101, 30.1766], [-122.5814, 37.9922], [-79.7626, 43.7059], [-98.233, 26.2759], [-88.2813, 40.1144], [-84.5496, 39.3367], [-2.4493, 52.6766], [-76.7285, 39.051], [-84.0852, 35.9279], [77.2, 28.6], [-122.3043, 47.6102], [10.4076, 59.2675], [-79.2656, 42.9998], [4.9, 52.3667], [-79.3935, 43.7301], [150.9, -34.4], [-95.9555, 36.1467], [-117.3647, 33.9298], [-77.2758, 39.4624], [54.0, 24.0], [-72.7956, 41.2864], [-88.1341, 41.8032], [-87.65, 41.85], [-105.6997, 37.9964], [-78.9858, 36.0378], [-8.162, 43.4682], [35.2833, 47.85], [-78.7484, 42.8356], [115.8614, -31.9522], [-73.6072, 45.5168], [-98.239, 26.2199], [-121.9875, 36.9713], [-118.2437, 34.0522], [-81.7329, 28.0222], [-71.4853, 42.5384], [-122.0381, 37.8916], [72.8258, 18.975], [-106.7177, 35.3275], [85.3167, 27.7167], [-96.0712, 36.0492], [-121.6631, 38.537], [-84.4044, 39.3376], [-88.396, 41.9422], [-122.1134, 47.6051], [-81.4788, 35.8448], [149.15, -35.3], [-81.7329, 28.0222], [-0.3321, 51.5783], [126.98, 37.57], [-81.5513, 35.9726], [-75.6155, 40.2605], [-83.0104, 42.5988], [-79.3036, 43.7812], [-118.8036, 55.1359], [-100.3167, 25.6667], [-73.7652, 45.5338], [144.9633, -37.814], [-117.3647, 33.9298], [55.3047, 25.2582], [-73.6072, 45.5168], [-73.9223, 40.8374], [-70.621, 41.4477], [-83.073, 40.1018], [-117.7858, 33.5558], [-98.4556, 29.4821], [-81.7329, 28.0222], [-97.8522, 34.4853], [-122.14, 37.3622], [-122.2721, 47.2257], [-111.7426, 33.604], [174.7942, -41.2466], [55.3047, 25.2582], [-122.0881, 37.3845], [-74.3969, 40.5183], [-74.037, 40.7639], [-70.8997, 41.7138], [-70.8578, 42.5653], [-79.4663, 44.0001], [-122.3177, 47.3078], [-79.3853, 43.702], [-3.6833, 40.4], [-83.1615, 40.0989], [-81.7329, 28.0222], [113.25, 23.1167], [-82.7459, 39.898], [-105.6328, 33.3539], [-118.3278, 34.0887]]

  for coordinate in coordinates
    xy = projection(coordinate)
    svg.append("circle").attr
      cx: xy[0],
      cy: xy[1],
      r: 2,
      fill: '#e2b506'
