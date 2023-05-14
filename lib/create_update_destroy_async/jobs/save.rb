# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Save < Base
      def perform(record, attributes = {})
        record.assign_attributes(attributes)
        record.save
      end
    end
  end
end
