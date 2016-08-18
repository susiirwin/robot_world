require_relative "../test_helper"

class UserSeesAllRobotsTest < FeatureTest
  def test_user_sees_all_robots
    robot_world.create({name: "Robot 1"})
    robot_world.create({name: "Robot 2"})

    visit '/robots'

    save_and_open_page

    assert page.has_content?("1: Robot 1")
    assert page.has_content?("2: Robot 2")
  end

end
