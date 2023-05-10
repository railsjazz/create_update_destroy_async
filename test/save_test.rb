require "test_helper"

class SaveTest < ActiveJob::TestCase
  setup do
    User.destroy_all
  end

  test "save_async 1" do
    user = User.create(name: "John Doe")
    assert_enqueued_jobs 0
    user.name = "Bob Smith"
    user.save_async
    assert_equal 0, User.where(name: "Bob Smith").count
    assert_enqueued_jobs 1
  end

  test "save_async 2" do
    user = User.create(name: "OLD")
    perform_enqueued_jobs do
      user.name = "NEW"
      user.save_async
    end
    assert_equal "NEW", User.first.name
  end

  test "save_async 3" do
    user = User.create(name: "OLD", age: 42)
    perform_enqueued_jobs do
      user.age = 43
      user.name = "NEW"
      user.save_async
    end
    assert_equal "NEW", User.first.name
    assert_equal 43, User.first.age
  end
end
