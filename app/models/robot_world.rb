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

  def group_by_department
    database.execute("SELECT department, COUNT(id) FROM robots GROUP BY department;")
  end

  def group_by_state
    database.execute("SELECT state, COUNT(id) FROM robots GROUP BY state;")
  end

  def group_by_city
    database.execute("SELECT city, COUNT(id) FROM robots GROUP BY city;")
  end

  def group_by_hire_year
    database.execute("SELECT strftime('%Y', date_hired) AS year, COUNT(id) FROM robots GROUP BY year;")
  end

  def get_robot_average_age
    database.execute("SELECT AVG(age) AS age FROM (SELECT (strftime('%Y', 'now') - strftime('%Y', birthday)) - (strftime('%m-%d', 'now') < strftime('%m-%d', birthday)) AS Age FROM robots);")[0]["age"].round(2)
  end
end
