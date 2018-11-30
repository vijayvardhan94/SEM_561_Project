require 'test_helper'

class WorkoutLoggersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workout_logger = workout_loggers(:one)
  end

  test "should get index" do
    get workout_loggers_url
    assert_response :success
  end

  test "should get new" do
    get new_workout_logger_url
    assert_response :success
  end

  test "should create workout_logger" do
    assert_difference('WorkoutLogger.count') do
      post workout_loggers_url, params: { workout_logger: { activitycalories: @workout_logger.activitycalories, date: @workout_logger.date, height: @workout_logger.height, sleependtime: @workout_logger.sleependtime, sleepstarttime: @workout_logger.sleepstarttime, steps: @workout_logger.steps, weight: @workout_logger.weight } }
    end

    assert_redirected_to workout_logger_url(WorkoutLogger.last)
  end

  test "should show workout_logger" do
    get workout_logger_url(@workout_logger)
    assert_response :success
  end

  test "should get edit" do
    get edit_workout_logger_url(@workout_logger)
    assert_response :success
  end

  test "should update workout_logger" do
    patch workout_logger_url(@workout_logger), params: { workout_logger: { activitycalories: @workout_logger.activitycalories, date: @workout_logger.date, height: @workout_logger.height, sleependtime: @workout_logger.sleependtime, sleepstarttime: @workout_logger.sleepstarttime, steps: @workout_logger.steps, weight: @workout_logger.weight } }
    assert_redirected_to workout_logger_url(@workout_logger)
  end

  test "should destroy workout_logger" do
    assert_difference('WorkoutLogger.count', -1) do
      delete workout_logger_url(@workout_logger)
    end

    assert_redirected_to workout_loggers_url
  end
end
