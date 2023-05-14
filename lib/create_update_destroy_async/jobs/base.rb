# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Base < ActiveJob::Base
      queue_as { ActiveRecord.queues[:create_update_destroy_async_queue] }

      discard_on ActiveJob::DeserializationError
    end
  end
end
