require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.last.id
  end

  def create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
  end

  def number_of_robots
    robot_world.all.count
  end

  def test_it_creates_a_robot
    create_robot
    robot = robot_world.find(current_robot_id)
    assert_equal "New Robot", robot.name
    assert_equal "Erie", robot.city
    assert_equal "CO", robot.state
    assert_equal "2016-08-26", robot.birthday
    assert_equal "2016-08-29", robot.date_hired
    assert_equal "BioMetrics", robot.department
  end

  def test_it_can_retrieve_all_items
    2.times { create_robot }

    assert_equal 2,robot_world.raw_robots.count
  end

  def test_it_can_show_all_robots
    2. times { create_robot }

    assert_equal 2, number_of_robots
  end

  def test_it_can_find_an_individual_robot_by_id
    2.times { create_robot }

    assert_equal 2, number_of_robots
    assert_instance_of Robot, robot_world.all.last
  end

  def test_it_can_return_an_individual_robot_by_id
    2.times { create_robot }

    assert_equal "New Robot", robot_world.find(current_robot_id).name
    assert_equal "New Robot", robot_world.find(current_robot_id).name
  end

  def test_it_can_find_a_robot_by_id_update_record
    2.times { create_robot }
    robot1, robot2 = robot_world.all
    params = {robot: {
      :name => "Ted",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      }}

    assert_equal "New Robot", robot1.name
    robot_world.update(robot1.id, params[:robot])
    robot1 = robot_world.all.first
    assert_equal "Ted", robot1.name
  end

  def test_it_can_find_a_robot_by_id_and_destroy_it
    2.times { create_robot }

    assert_equal 2, number_of_robots
    robot_world.destroy(current_robot_id)
    assert_equal 1, number_of_robots
  end

  def test_it_can_destroy_all_robots
    2.times { create_robot }

    assert_equal 2, number_of_robots
    robot_world.delete_all
    assert_equal 0, number_of_robots
  end

  def test_it_groups_robots_based_on_dept
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Home Science"
      })

    assert_equal [{"department"=>"BioMetrics", "COUNT(id)"=>1, 0=>"BioMetrics", 1=>1}, {"department"=>"Home Science", "COUNT(id)"=>1, 0=>"Home Science", 1=>1}], robot_world.group_by_department
  end

  def test_it_groups_robots_based_on_states
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Home Science"
      })

      assert_equal [{"state"=>"CO", "COUNT(id)"=>1, 0=>"CO", 1=>1}, {"state"=>"NJ", "COUNT(id)"=>1, 0=>"NJ", 1=>1}], robot_world.group_by_state
  end

  def test_it_groups_robots_by_City
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Home Science"
      })
      robot_world.create({
        :name => "New Robot",
        :city => "Newton",
        :state => "NJ",
        :birthday => "2016-08-26",
        :date_hired => "2016-08-29",
        :department => "Home Science"
        })

      expected = [{"city"=>"Erie", "COUNT(id)"=>1, 0=>"Erie", 1=>1}, {"city"=>"Newton", "COUNT(id)"=>2, 0=>"Newton", 1=>2}]
      assert_equal expected, robot_world.group_by_city
  end

  def test_it_groups_by_hire_year
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "2016-08-26",
      :date_hired => "2015-08-29",
      :department => "Home Science"
      })
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "2016-08-26",
      :date_hired => "2014-08-29",
      :department => "Home Science"
      })

    assert_equal [{"strftime('%Y', date_hired)"=>"2014", "COUNT(id)"=>3, 0=>"2014", 1=>3}], robot_world.group_by_hire_year
  end

  def test_it_can_get_a_robots_age
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "2006-08-26",
      :date_hired => "2016-08-29",
      :department => "Home Science"
      })
      robot_world.create({
        :name => "New Robot",
        :city => "Newton",
        :state => "NJ",
        :birthday => "1998-08-16",
        :date_hired => "2016-08-29",
        :department => "Home Science"
        })
    expected = [{"age"=>13.5, 0=>13.5}]

    assert_equal expected, robot_world.get_robot_average_age
  end

end
