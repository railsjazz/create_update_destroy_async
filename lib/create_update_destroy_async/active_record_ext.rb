module CreateUpdateDestroyAsync
  module ActiveRecordExt
    extend ActiveSupport::Concern

    class_methods do
      def create_async(attributes = {})
        CreateUpdateDestroyAsync::Jobs::Create.perform_later(self.name, attributes)
      end
    end

    def save_async
      new_attributes = changes.each_with_object({}) do |(k, v), hash|
        hash[k] = v[1]
      end
      CreateUpdateDestroyAsync::Jobs::Save.perform_later(self, new_attributes)
    end

    def update_async(new_attributes = {})
      CreateUpdateDestroyAsync::Jobs::Update.perform_later(self, changed_attributes.merge(new_attributes))
    end

    def destroy_async
      CreateUpdateDestroyAsync::Jobs::Destroy.perform_later(self)
    end
  end
end
