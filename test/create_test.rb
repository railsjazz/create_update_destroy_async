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

  test "job name" do
    # Clear the enqueued jobs before testing
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear

    User.create_async

    # Check if the job was enqueued
    assert_enqueued_jobs 1

    # Check the job name
    enqueued_job = ActiveJob::Base.queue_adapter.enqueued_jobs.first
    assert_equal 'CreateUpdateDestroyAsync::Jobs::Create', enqueued_job[:job].to_s
  end

  test "job name and args" do
    # Clear the enqueued jobs before testing
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear

    User.create_async(name: "John Doe")

    # Check if the job was enqueued
    assert_enqueued_jobs 1

    # Check the job name
    enqueued_job = ActiveJob::Base.queue_adapter.enqueued_jobs.first
    assert_equal 'CreateUpdateDestroyAsync::Jobs::Create', enqueued_job[:job].to_s
    assert_equal(["User", {"name"=>"John Doe", "_aj_symbol_keys"=>["name"]}], enqueued_job[:args])
  end
end
