require "test_helper"
require 'benchmark'

class CreateUpdateDestroyAsyncTest < ActiveJob::TestCase
  setup do
    clear_db
  end

  test "benchmark create_async" do
    def users_sync
      User.create
    end

    def users_async
      User.create_async
    end

    # Warm up
    2.times { users_sync }
    2.times { users_async }

    puts

    # Benchmark
    Benchmark.bm do |bm|
      bm.report("users_sync") { 100.times { users_sync } }
      bm.report("users_async") { 100.times { users_async } }
    end

    puts
  end
end
