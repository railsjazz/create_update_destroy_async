require "test_helper"

class UpdateTest < ActiveJob::TestCase
  setup do
    User.destroy_all
  end

  test "update_async 1" do
    user = User.create(name: "John Doe")
    assert_enqueued_jobs 0
    user.update_async(name: "Bob Smith")
    assert_equal 0, User.where(name: "Bob Smith").count
    assert_enqueued_jobs 1
  end

  test "update_async 2" do
    user = User.create(name: "John Doe")
    perform_enqueued_jobs do
      user.update_async(name: "Bob Smith")
    end
    assert_equal "Bob Smith", User.first.name
  end

  test "update_async 3" do
    user = User.create(name: "John Doe", age: 42)
    perform_enqueued_jobs do
      user.age = 43
      user.update_async(name: "Bob Smith")
    end
    assert_equal "Bob Smith", User.first.name
    assert_equal 42, User.first.age
  end

  test "update_async 4" do
    a = User.create(name: "A")
    b = User.create(name: "B")
    p = a.projects.create(title: "P")

    perform_enqueued_jobs do
      p.update_async(user: b)
    end

    assert_equal b, p.reload.user
  end
end
