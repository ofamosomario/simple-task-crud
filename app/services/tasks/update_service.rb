# frozen_string_literal: true

module Tasks
  # Service object for updating Task records
  class UpdateService
    attr_reader :errors, :record

    def initialize(record, parameters = {})
      @record = record
      @parameters = parameters
      @errors = []
      @success = false
    end

    def success?
      @success
    end

    def update
      update_record(@record)
      @record
    end

    private

    def update_record(record)
      if record.update(@parameters)
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
