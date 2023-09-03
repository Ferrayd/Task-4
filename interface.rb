# frozen_string_literal: true

class TrainApp
  CAR_TYPES = { 'cargo' => CargoCar, 'passenger' => PassengerCar }.freeze

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def action
    loop do
      show_actions
      choice = gets.chomp.to_i

      case choice
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        add_wagon_to_train
      when 4
        remove_wagon_from_train
      when 5
        move_train_to_station
      when 6
        list_stations
      when 7
        list_trains_on_station
      when 8
        list_all_trains
      else
        show_actions_prompt
      end
    end
  end

  private

  def show_actions
    print("
    Введите номер команды:
    0. Выход
    1. Создать станцию
    2. Создать поезд
    3. Прицепить вагон к поезду
    4. Отцепить вагон от поезда
    5. Поместить поезд на станцию
    6. Просмотреть список станций
    7. Просмотреть список поездов находящихся на станции
    8. Список всех поездов
    >>".chomp)
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @stations << Station.new(name)
    puts "Построена станция #{name}"
  end

  def create_route
    list_stations
    puts 'Введите начальную станцию:'
    first_station_name = gets.chomp
    first_station = @stations.find { |station| station.name = first_station_name}
    puts 'Введите конечную станцию:'
    last_station_name = gets.chomp
    last_station = @stations.find { |station| station.name = last_station_name}
    @routes << Route.new(first_station, last_station)
  end

  def add_station

  end

  def create_train
    puts 'C каким номером?'
    number = gets.chomp
    puts '1 - пассажирский, 2 - грузовой'
    choice = gets.chomp.to_i
    case choice
    when 1
      @trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд №#{number}"
    when 2
      @trains << CargoTrain.new(number)
      puts "Создан грузовой поезд №#{number}"
    else
      puts 'Поезд не создан. Введите 1 или 2'
    end
  end

  def add_wagon_to_train
    if @trains.empty?
      puts 'Сначала создайте поезд'
    else
      puts 'К какому? (введите номер)'
      number = gets.chomp
      train = @trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        train.add_car(train)
      end
    end
  end

  def remove_wagon_from_train
    if @trains.empty?
      puts 'Сначала создайте поезд'
    else
      puts 'От какого? (введите номер)'
      number = gets.chomp
      train = @trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      elsif train.cars.empty?
        puts 'У этого поезда и так нет вагонов'
      else
        train.remove_car(train.cars.last)
      end
    end
  end

  def move_train_to_station
    if @trains.empty?
      puts 'Сначала Сначала создайте поезд'
    elsif @stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'Какой поезд? (введите номер)'
      number = gets.chomp
      train = @trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        puts 'На какую станцию? (название)'
        name = gets.chomp
        station = @stations.detect { |station| station.name == name }
        if station.nil?
          puts 'Такой станции нет'
        else
          station.get_train(train)
        end
      end
    end
  end

  def list_stations
    puts 'Список станций:'
    @stations.each { |station| puts station.name }
  end

  def list_trains_on_station
    if @stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'На какой? (название)'
      name = gets.chomp
      station = @stations.detect { |station| station.name == name }
      if station.nil?
        puts 'Такой станции нет'
      else
        station.show_trains
      end
    end
  end

  def list_all_trains
    puts 'Список поездов:'
    @trains.each { |train| puts "#{train.number} #{train.type}"}
  end

  def show_actions_prompt
    puts 'Необходимо выбрать один из предложенных вариантов'
  end
end

my_app = TrainApp.new
my_app.action
