require "test_helper"

class SaveTest < ActiveJob::TestCase
  setup do
    clear_db
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

  test "save_async 4" do
    user1 = User.create(name: "OLD")
    user2 = User.create(name: "NEW")
    project = user1.projects.create(title: "OLD")
    perform_enqueued_jobs do
      project.user = user2
      project.save_async
    end
    assert_equal user2, project.reload.user
  end

  test "sets custom queue" do
    user = User.create(name: "John Doe")
    user.name = "Bob Smith"
    user.save_async(queue: "test")

    assert_enqueued_with(job: CreateUpdateDestroyAsync::Jobs::Save, queue: "test")
  end
end
