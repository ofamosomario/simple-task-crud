# frozen_string_literal: true

module Tasks
  # Service object for creating Task records
  class CreateService
    attr_reader :errors, :record

    def initialize(parameters = {})
      @parameters = parameters

      @errors = []
      @record = nil
      @success = false
    end

    def success?
      @success
    end

    def create
      record = Task.new
      save_record(record)
      @record
    end

    def save_record(record)
      record.assign_attributes(@parameters)
      if record.save
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
