require 'test_helper'

class UserFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_file = user_files(:one)
    @file_1 = fixture_file_upload('files/test.csv', 'text/csv')
    @file_2 = fixture_file_upload('files/test2.csv', 'text/csv')
  end

  test "should get index" do
    get user_files_url
    assert_response :success
  end

  test "should get new" do
    get new_user_file_url
    assert_response :success
  end

  test "should create user_file from file_1" do
    assert_enqueued_jobs 0

    assert_difference('UserFile.count') do
      post user_files_url,
           params: { user_file: { name: "test1",
                                  csv_file: @file_1 } }
    end

    user_file = UserFile.last
    assert_redirected_to user_file_url(user_file)

    assert_enqueued_jobs 2

    perform_enqueued_jobs
    assert_equal(6, user_file.users.with_error.count)
    assert_equal(1, user_file.users.without_error.count)
  end

  test "should create user_file from file_2" do
    assert_enqueued_jobs 0

    assert_difference('UserFile.count') do
      post user_files_url,
           params: { user_file: { name: "test2",
                                  csv_file: @file_2 } }
    end

    user_file = UserFile.last
    assert_redirected_to user_file_url(user_file)

    assert_enqueued_jobs 2

    perform_enqueued_jobs
    assert_equal(0, user_file.users.with_error.count)
    assert_equal(2, user_file.users.without_error.count)
  end

  test "should not create user_file when using same name" do
    assert_enqueued_jobs 0

    assert_no_difference('UserFile.count') do
      post user_files_url,
           params: { user_file: { name: @user_file.name,
                                  csv_file: @file_1 } }
    end

    user_file = UserFile.last
    assert_redirected_to user_file_url(user_file)

    assert_enqueued_jobs 2

    perform_enqueued_jobs
    assert_equal(6, user_file.users.with_error.count)
    assert_equal(1, user_file.users.without_error.count)
  end

  test "should show user_file" do
    get user_file_url(@user_file)
    assert_response :success
  end

end
