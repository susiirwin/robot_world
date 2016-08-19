require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.execute("INSERT INTO robots (name, city, state, birthday, date_hired, department) VALUES (?, ?, ?, ?, ?, ?);", robot[:name], robot[:city], robot[:state], robot[:birthday], robot[:date_hired], robot[:department])
  end

  def raw_robots
    database.execute("SELECT * FROM robots;")
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    database.execute("SELECT * FROM robots WHERE id=?;", id).first
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot_data)
    database.execute("UPDATE robots SET name=?, city=?, state=?, birthday=?, date_hired=?, department=? WHERE id=?;", robot_data[:name], robot_data[:city], robot_data[:state], robot_data[:birthday], robot_data[:date_hired], robot_data[:department], id)
  end

  def destroy(id)
    database.execute("DELETE FROM robots WHERE id=?;", id)
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end
end
