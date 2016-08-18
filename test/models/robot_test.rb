require_relative "../test_helper"

class RobotTest < Minitest::Test
  def test_it_assigns_attributes_correctly
    robot = Robot.new({
      "id" => 1,
      "name" => "Test Robot",
      "city" => "Test City",
      "state" => "CO",
      "birthday" => "2016-08-24",
      "date_hired" => "2016-08-25",
      "department" => "BioMetrics"
      })

    assert_equal 1, robot.id
    assert_equal "Test Robot", robot.name
    assert_equal "Test City", robot.city
    assert_equal "CO", robot.state
    assert_equal "2016-08-24", robot.birthday
    assert_equal "2016-08-25", robot.date_hired
    assert_equal "BioMetrics", robot.department
  end
end
