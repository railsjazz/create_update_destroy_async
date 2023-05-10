# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Create < ActiveJob::Base
      def perform(klass, attributes)
        model = klass.constantize
        model.create(attributes)
      end
    end
  end
end
