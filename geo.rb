class GeoPoint
  attr_accessor :lat, :long

  def initialize(lat, long)
    @lat = lat
    @long = long
  end
end

module Geo
  module_function

  extend Math

  EARTH_RADIUS = 6378100

  def harvestine_distance(lat1, long1, lat2, long2)
    lat1 = to_radians(lat1)
    long1 = to_radians(long1)
    lat2 = to_radians(lat2)
    long2 = to_radians(long2)

    d_lat = lat2 - lat1
    d_long = long2 - long1

    tg2 = sin(d_lat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(d_long / 2) ** 2

    central_angle = 2 * atan2(sqrt(tg2), sqrt(1 - tg2))

    central_angle * EARTH_RADIUS
  end

  def to_radians(degrees)
    degrees * Math::PI / 180
  end
end
