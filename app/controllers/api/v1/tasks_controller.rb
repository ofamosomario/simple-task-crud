# frozen_string_literal: true

module Api
  module V1
    # Api V1 TasksController
    class TasksController < ApplicationController
      include TaskScoped
      def index
        render json: Task.all
      end

      def show
        render json: @task
      end

      def create
        service = Tasks::CreateService.new(tasks_params)
        service.create

        if service.success?
          render json: service.record, status: :created
        else
          render json: { errors: service.errors }, status: :bad_request
        end
      end

      def update
        service = Tasks::UpdateService.new(@task, tasks_params)

        if service.update
          render json: service.record, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        service = Tasks::DestroyService.new(@task)
        service.destroy

        if service.success?
          render json: { message: 'Task deleted successfully.' }, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def tasks_params
        params.permit(:brand, :price, :url, :status, :car_model)
      end
    end
  end
end
