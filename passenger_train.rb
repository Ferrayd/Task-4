class PassengerTrain < PassengerTrain

  def initialize(number, type = "passenger")
    super
  end

  def add_car(car)
    if car.instance_of?(PassengerCar)
      super(car)
    else
      puts "Извините, пассажирскому поезду можно прицепить только пассажирский вагон."
    end
  end

end
