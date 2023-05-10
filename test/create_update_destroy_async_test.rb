require "test_helper"

class CreateUpdateDestroyAsyncTest < ActiveJob::TestCase
  test "it has a version number" do
    assert CreateUpdateDestroyAsync::VERSION
  end
end
