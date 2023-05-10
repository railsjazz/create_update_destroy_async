# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Update < ActiveJob::Base
      def perform(record, attributes)
        record.update(attributes)
      end
    end
  end
end
