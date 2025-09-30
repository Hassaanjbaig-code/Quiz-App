require "test_helper"

class QuizsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Enter the quiz" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Quiz"
    post quizs_path, params: { name: "Ali", question: "Question #1 Which device is considered the “brain” of the computer?
Options: a) Monitor, b) CPU, c) Keyboard, d) Mouse
Correct Answer: b) CPU

Question #2 Which device is used for permanent data storage?
Options: a) RAM, b) Hard Disk, c) Cache, d) Register
Correct Answer: b) Hard Disk" }
    assert_redirected_to start_path
  end

  test "check the MCQS" do
    name = "Ali"
    post quizs_path, params: { name: name, question: "Question #1 Which device is considered the “brain” of the computer?
    Options: a) Monitor, b) CPU, c) Keyboard, d) Mouse
    Correct Answer: b) CPU

    Question #2 Which device is used for permanent data storage?
    Options: a) RAM, b) Hard Disk, c) Cache, d) Register
    Correct Answer: b) Hard Disk" }
    assert_redirected_to start_path
    follow_redirect!
    assert_template "quizs/show"
    assert_select "h1", text: "Quiz Started #{name}"
    assert_select "input[type=radio]", count: 4
  end
end
