require './geo.rb'

module MoscowPoints
  module_function

  extend Math

  MOSCOW_CENTER = GeoPoint.new(55.751548, 37.618847).freeze
  MOSCOW_RADIUS = 20000.0

  def generate(n)
    (1..n).map do
      radius = rand(0..MOSCOW_RADIUS)
      angle = rand(0..(2.0 * Math::PI))
      dx = radius * cos(angle)
      dy = radius * sin(angle)
      d_long = to_degrees((dx / cos(to_radians(MOSCOW_CENTER.lat))) / Geo::EARTH_RADIUS)
      d_lat = to_degrees(dy / Geo::EARTH_RADIUS)

      GeoPoint.new(MOSCOW_CENTER.lat + d_lat, MOSCOW_CENTER.long + d_long)
    end
  end

  def to_degrees(radians)
    radians / Math::PI * 180
  end

  def to_radians(degrees)
    degrees * Math::PI / 180
  end
end