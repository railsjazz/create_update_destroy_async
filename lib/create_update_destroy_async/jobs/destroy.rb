# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Destroy < Base
      def perform(record)
        record.destroy
      end
    end
  end
end
