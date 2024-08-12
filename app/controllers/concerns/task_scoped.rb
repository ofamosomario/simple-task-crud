# frozen_string_literal: true

module TaskScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_task, only: %i[show update destroy]

    private

    def set_task
      @task = Task.find(params[:id])
    end
  end
end
