module Geo
  module_function

  extend Math

  EARTH_RADIUS = 6378100

  def harvestine_distance(lat1, lon1, lat2, lon2)
    lat1 = to_radians(lat1)
    lon1 = to_radians(lon1)
    lat2 = to_radians(lat2)
    lon2 = to_radians(lon2)

    d_lat = lat2 - lat1
    d_lon = lon2 - lon1

    tg2 = sin(d_lat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(d_lon / 2) ** 2

    central_angle = 2 * atan2(sqrt(tg2), sqrt(1 - tg2))

    central_angle * EARTH_RADIUS
  end

  def to_radians(degrees)
    degrees * Math::PI / 180
  end
end

puts Geo.harvestine_distance(46.3625, 15.114444, 46.055556, 14.508333)