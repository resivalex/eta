require './geo.rb'

class Car
  attr_accessor :geo_point
  attr_accessor :available

  def initialize(geo_point, available)
    @geo_point = geo_point
    @available = available
  end

  def lat
    geo_point.lat
  end

  def long
    geo_point.long
  end
end

class CarPark
  METERS_TO_ETA = 1.5 / 1000

  attr_accessor :cars

  def initialize
    @cars = []
  end

  def eta(lat, long)
    car = Car.new(GeoPoint.new(55.760446, 37.640821), true)
    distance = Geo.harvestine_distance(car.lat, car.long, lat, long)
    distance * METERS_TO_ETA
  end
end
