require "test_helper"

class CreateUpdateDestroyAsyncTest < ActiveJob::TestCase
  setup do
    clear_db
  end

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

  test "create_async 3" do
    assert_nothing_raised do
      User.create_async
    end
  end

  test "create_async 4" do
    perform_enqueued_jobs do
      User.create.projects.create_async
    end
    assert_equal 1, Project.count
  end
end
