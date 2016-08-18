require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'],
                              "name" => robot[:name],
                              "city" => robot[:city],
                              "state" => robot[:state],
                              "birthday" => robot[:birthday],
                              "date_hired" => robot[:date_hired],
                              "department" => robot[:department] }
    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot_data)
    database.transaction do
      robot = database["robots"].find { |data| data["id"] == id }
      robot["name"] = robot_data[:name]
      robot["city"] = robot_data[:city]
      robot["state"] = robot_data[:state]
      robot["birthday"] = robot_data[:birthday]
      robot["date_hired"] = robot_data[:date_hired]
      robot["department"] = robot_data[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database["robots"].delete_if { |robot| robot["id"] == id }
    end
  end

  def delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end
end
