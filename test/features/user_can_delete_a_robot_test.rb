require_relative '../test_helper'

class UserCanCreateANewRobotTest < FeatureTest
  def test_it_creates_a_new_robot
    robot_world.create({name: "Robot 1"})

    visit '/'

    click_link("See all of the Robots")

    assert_equal "/robots", current_path

    click_link("Robot 1")

    assert_equal "/robots/1", current_path

    save_and_open_page

    click_on("Delete this Robot")

    assert_equal '/robots', current_path

    save_and_open_page

  end
end
