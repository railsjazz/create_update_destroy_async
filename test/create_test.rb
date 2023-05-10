require "test_helper"

class CreateUpdateDestroyAsyncTest < ActiveJob::TestCase
  test "create_async 1" do
    assert_enqueued_jobs 0
    User.create_async(name: "John Doe")
    assert_equal 0, User.count
    assert_enqueued_jobs 1
  end

  test "create_async 2" do
    perform_enqueued_jobs do
      User.create_async(name: "John Doe")
    end
    assert_equal 1, User.count
  end
end
