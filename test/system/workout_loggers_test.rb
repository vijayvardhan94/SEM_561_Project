require "application_system_test_case"

class WorkoutLoggersTest < ApplicationSystemTestCase
  setup do
    @workout_logger = workout_loggers(:one)
  end

  test "visiting the index" do
    visit workout_loggers_url
    assert_selector "h1", text: "Workout Loggers"
  end

  test "creating a Workout logger" do
    visit workout_loggers_url
    click_on "New Workout Logger"

    fill_in "Activitycalories", with: @workout_logger.activitycalories
    fill_in "Date", with: @workout_logger.date
    fill_in "Height", with: @workout_logger.height
    fill_in "Sleependtime", with: @workout_logger.sleependtime
    fill_in "Sleepstarttime", with: @workout_logger.sleepstarttime
    fill_in "Steps", with: @workout_logger.steps
    fill_in "Weight", with: @workout_logger.weight
    click_on "Create Workout logger"

    assert_text "Workout logger was successfully created"
    click_on "Back"
  end

  test "updating a Workout logger" do
    visit workout_loggers_url
    click_on "Edit", match: :first

    fill_in "Activitycalories", with: @workout_logger.activitycalories
    fill_in "Date", with: @workout_logger.date
    fill_in "Height", with: @workout_logger.height
    fill_in "Sleependtime", with: @workout_logger.sleependtime
    fill_in "Sleepstarttime", with: @workout_logger.sleepstarttime
    fill_in "Steps", with: @workout_logger.steps
    fill_in "Weight", with: @workout_logger.weight
    click_on "Update Workout logger"

    assert_text "Workout logger was successfully updated"
    click_on "Back"
  end

  test "destroying a Workout logger" do
    visit workout_loggers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Workout logger was successfully destroyed"
  end
end
