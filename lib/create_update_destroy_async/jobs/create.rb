# frozen_string_literal: true

module CreateUpdateDestroyAsync
  module Jobs
    class Create < Base
      def perform(klass, attributes = {})
        model = klass.constantize
        model.create(attributes)
      end
    end
  end
end
