require_relative "../test_helper"

class UserSeesAllRobotsTest < FeatureTest
  def test_user_can_update_robot_information
    robot_world.create({name: "Robot 1"})

    visit '/'

    click_on("See all of the Robots")

    assert_equal '/robots', current_path

    click_on("Robot 1")

    assert_equal '/robots/1', current_path

    click_on("Edit Robot Details")

    save_and_open_page

    assert_equal '/robots/1/edit', current_path

    fill_in('robot[name]', :with => 'Amanda')

    click_on("Update")

    assert_equal '/robots/1', current_path

    save_and_open_page
  end
end
