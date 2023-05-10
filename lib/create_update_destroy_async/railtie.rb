module CreateUpdateDestroyAsync
  class Railtie < ::Rails::Railtie
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.send(:include, CreateUpdateDestroyAsync::ActiveRecordExt)
    end
  end
end
