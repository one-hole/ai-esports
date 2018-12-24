module FilterConcern
  extend ActiveSupport::Concern

  class_methods do
    def filters(filters_params)
      records = self.where(nil)
      filters_params.each { |key, value| records = records.public_send("with_#{key}", value) if value.present? }
      return records
    end
  end
end
