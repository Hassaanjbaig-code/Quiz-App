require "test_helper"

class QuizsStartControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get quizs_start_create_url
    assert_response :success
  end
end
