require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot = robot_world.find(1)
    assert_equal "New Robot", robot.name
    assert_equal "Erie", robot.city
    assert_equal "CO", robot.state
    assert_equal "2016-08-26", robot.birthday
    assert_equal "2016-08-29", robot.date_hired
    assert_equal "BioMetrics", robot.department
  end

  def test_it_can_retrieve_all_items_from_YAML_database
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    assert_equal 2,robot_world.raw_robots.count
  end

  def test_it_can_show_all_robots
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    assert_equal 2, robot_world.all.count
  end

  def test_it_can_find_an_individual_robot_in_YAML_database_by_id
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    expected1 = {"id"=>1, "name"=>"New Robot", "city"=>"Erie", "state"=>"CO", "birthday"=>"2016-08-26", "date_hired"=>"2016-08-29", "department"=>"BioMetrics"}

    expected2 = {"id"=>2, "name"=>"Another New Robot", "city"=>"Boulder", "state"=>"CO", "birthday"=>"2016-08-26", "date_hired"=>"2016-08-29", "department"=>"Physics"}

    assert_equal expected1, robot_world.raw_robot(1)
    assert_equal expected2, robot_world.raw_robot(2)
  end

  def test_it_can_return_an_individual_robot_by_id
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

      assert_equal "New Robot", robot_world.find(1).name
      assert_equal "Another New Robot", robot_world.find(2).name
  end

  def test_it_can_find_a_robot_by_id_update_record
    robot1 = robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot2 = robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    robot_data = { robot: { name: "Ted" } }
    assert_equal "New Robot"
    robot_world.update(1, robot_data)
    assert_equal "Ted", robot1.name


  end

  def test_it_can_find_a_robot_by_id_and_destroy_it
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    assert_equal 2, robot_world.all.count
    robot_world.destroy(1)
    assert_equal 1, robot_world.all.count
  end

  def test_it_can_destroy_all_robots_in_the_YAML_database
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "BioMetrics"
      })
    robot_world.create({
      :name => "Another New Robot",
      :city => "Boulder",
      :state => "CO",
      :birthday => "2016-08-26",
      :date_hired => "2016-08-29",
      :department => "Physics"
      })

    assert_equal 2, robot_world.all.count
    robot_world.delete_all
    assert_equal 0, robot_world.all.count
  end
end
