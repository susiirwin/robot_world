require_relative "../test_helper"

class UserSeesAllRobotsTest < FeatureTest
  def test_user_can_update_robot_information
    robot_world.create({name: "Robot 1"})
    robot = robot_world.all.last
    visit "/robots/#{robot.id}"

    click_on("Edit Robot Details")

    save_and_open_page

    assert_equal "/robots/#{robot.id}/edit", current_path

    fill_in('robot[name]', :with => 'Amanda')

    click_on("Update")

    assert_equal "/robots/#{robot.id}", current_path

    save_and_open_page
  end
end
