require_relative "../test_helper"

class UserSeesASingleRobotsTest < FeatureTest
  def test_user_sees_all_robots
    robot_world.create({name: "Robot 1"})
    robot_world.create({name: "Robot 2"})

    visit '/'

    click_link("See all of the Robots")

    assert_equal "/robots", current_path

    assert page.has_content?("1: Robot 1")

    click_link ("Robot 1")

    assert_equal '/robots/1', current_path
  end

end
