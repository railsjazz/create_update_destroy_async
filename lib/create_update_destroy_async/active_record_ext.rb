module CreateUpdateDestroyAsync
  module ActiveRecordExt
    extend ActiveSupport::Concern

    class_methods do
      def create_async(attributes = {}, queue: :default)
        CreateUpdateDestroyAsync::Jobs::Create.set(queue: queue).perform_later(self.name, attributes)
      end
    end

    def save_async(queue: :default)
      new_attributes = changes.each_with_object({}) do |(k, v), hash|
        hash[k] = v[1]
      end
      CreateUpdateDestroyAsync::Jobs::Save.set(queue: queue).perform_later(self, new_attributes)
    end

    def update_async(attributes = {}, queue: :default)
      CreateUpdateDestroyAsync::Jobs::Update.set(queue: queue).perform_later(self, changed_attributes.merge(attributes))
    end

    def destroy_async(queue: :default)
      CreateUpdateDestroyAsync::Jobs::Destroy.set(queue: queue).perform_later(self)
    end
  end
end
