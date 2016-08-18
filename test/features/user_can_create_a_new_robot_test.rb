require_relative '../test_helper'

class UserCanCreateANewRobotTest < FeatureTest
  def test_it_creates_a_new_robot
    visit '/'

    click_link("Make a New Robot")

    assert_equal "/robots/new", current_path

    fill_in('robot[name]', :with => 'Joshua')
    fill_in('robot[city]', :with => 'Erie')
    find('#state_dropdown').find(:xpath, 'option[6]').select_option
    fill_in('robot[birthday]', :with => '1981-02-07')
    fill_in('robot[date_hired]', :with => '2016-08-17')
    find('#dept_dropdown').find(:xpath, 'option[2]').select_option

    save_and_open_page

    click_on('Create this Robot!')

    assert_equal "/robots", current_path

    assert page.has_content?("Joshua")

    save_and_open_page
  end

end
