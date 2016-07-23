require './geo.rb'
require './moscow_points.rb'

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

  def distance(lat, long)
    Geo.harvestine_distance(self.lat, self.long, lat, long)
  end
end

class CarPark
  METERS_TO_ETA = 1.5 / 1000
  ETA_CAR_COUNT = 3

  attr_accessor :cars

  def initialize
    @cars = MoscowPoints.generate(1000).map do |point|
      Car.new(point, rand(2) == 0)
    end
  end

  def available_cars
    @cars.select(&:available)
  end

  def eta(lat, long)
    distances = available_cars.map { |car| car.distance(lat, long) }
    distance = distances.sort.first(ETA_CAR_COUNT).inject(:+) / ETA_CAR_COUNT

    distance * METERS_TO_ETA
  end
end
