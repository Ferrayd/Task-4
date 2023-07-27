# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'car'
require_relative 'cargo_train'
require_relative 'cargo_car'
require_relative 'passenger_train'
require_relative 'passenger_car'

class TrainApp
  CAR_TYPES = { 'cargo' => CargoCar, 'passenger' => PassengerCar }.freeze

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

  def action(choise)
    case choise.to_i
    when 0
      exit
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

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    stations << Station.new(name)
    puts "Построена станция #{name}"
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
    if trains.empty?
      puts 'Сначала создайте поезд'
    else
      puts 'К какому? (введите номер)'
      number = gets.chomp
      train = trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        train.add_car(CAR_TYPES[train.type].new)
      end
    end
  end

  def remove_wagon_from_train
    if trains.empty?
      puts 'Сначала создайте поезд'
    else
      puts 'От какого? (введите номер)'
      number = gets.chomp
      train = trains.detect { |train| train.number == number }
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
    if trains.empty?
      puts 'Сначала Сначала создайте поезд'
    elsif stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'Какой поезд? (введите номер)'
      number = gets.chomp
      train = trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        puts 'На какую станцию? (название)'
        name = gets.chomp
        station = stations.detect { |station| station.name == name }
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
    stations.each { |station| puts station.name }
  end

  def list_trains_on_station
    if stations.empty?
      puts 'Сначала создайте станцию'
    else
      puts 'На какой? (название)'
      name = gets.chomp
      station = stations.detect { |station| station.name == name }
      if station.nil?
        puts 'Такой станции нет'
      else
        station.show_trains
      end
    end
    def show_actions_prompt
      puts 'Необходимо выбрать один из предложенных вариантов'
    end
  end
end

my_app = TrainApp.new
my_app.show_actions
choise = gets.chomp
my_app.action(choise)
#   def list_all_trains
#   end
#
#   def show_actions_prompt
#   end
#
#
#
#
# puts %Q(
# 0. Выход
# 1. Создать станцию
# 2. Создать поезд
# 3. Прицепить вагон к поезду
# 4. Отцепить вагон от поезда
# 5. Поместить поезд на станцию
# 6. Просмотреть список станций
# 7. Просмотреть список поездов находящихся на станции
#   )
# loop do
#   print "Введите номер команды: "
#   choice = gets.chomp.to_i
#   case choice
#
#   when 0 #Выход
#     puts "До новых встреч!"
#     break
#
#   when 1 #Создать станцию
#     puts "Введите название станции"
#     name = gets.chomp
#     stations << Station.new(name)
#     puts "Построена станция #{name}"
#
#   when 2 #Создать поезд
#     puts "C каким номером?"
#     number = gets.chomp
#     puts "1 - пассажирский, 2 - грузовой"
#     choice = gets.chomp.to_i
#     case choice
#     when 1
#       trains << PassengerTrain.new(number)
#       puts "Создан пассажирский поезд №#{number}"
#     when 2
#       trains << CargoTrain.new(number)
#       puts "Создан грузовой поезд №#{number}"
#     else
#       puts "Поезд не создан. Введите 1 или 2"
#     end
#
#   when 3 #Прицепить вагон к поезду
#     if trains.empty?
#       puts "Сначала создайте поезд"
#     else
#       puts "К какому? (введите номер)"
#       number = gets.chomp
#       train = trains.detect{|train| train.number == number}
#       if train.nil?
#         puts "Поезда с таким номером нет"
#       else
#         train.add_car(CAR_TYPES[train.type].new)
#       end
#     end
#
#   when 4 #Отцепить вагон от поезда
#     if trains.empty?
#       puts "Сначала создайте поезд"
#     else
#       puts "От какого? (введите номер)"
#       number = gets.chomp
#       train = trains.detect{|train| train.number == number}
#       if train.nil?
#         puts "Поезда с таким номером нет"
#       elsif train.cars.empty?
#         puts "У этого поезда и так нет вагонов"
#       else
#         train.remove_car(train.cars.last)
#       end
#     end
#
#   when 5 #Поместить поезд на станцию
#     if trains.empty?
#       puts "Сначала Сначала создайте поезд"
#     elsif stations.empty?
#       puts "Сначала создайте станцию"
#     else
#       puts "Какой поезд? (введите номер)"
#       number = gets.chomp
#       train = trains.detect{|train| train.number == number}
#       if train.nil?
#         puts "Поезда с таким номером нет"
#       else
#         puts "На какую станцию? (название)"
#         name = gets.chomp
#         station = stations.detect{|station| station.name == name}
#         if station.nil?
#           puts "Такой станции нет"
#         else
#           station.get_train(train)
#         end
#       end
#     end
#
#   when 6 #Просмотреть список станций
#     puts "Список станций:"
#     stations.each{|station| puts station.name}
#
#   when 7 #Просмотреть список поездов на станции
#     if stations.empty?
#       puts "Сначала создайте станцию"
#     else
#       puts "На какой? (название)"
#       name = gets.chomp
#       station = stations.detect{|station| station.name == name}
#       if station.nil?
#         puts "Такой станции нет"
#       else
#         station.show_trains
#       end
#     end
#   else
#     puts "Необходимо выбрать один из предложенных вариантов"
#   end
# end
