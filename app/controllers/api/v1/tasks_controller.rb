module Api
  module V1
    class TasksController < ApplicationController
      # No authentication needed, so I'm nullifying it.
      protect_from_forgery with: :null_session

      def index
        tasks = Task.all
        render json: {status: 'SUCCESS', message: 'Task events loaded.', data: tasks}, status: :ok
      end

      def show
        task = Task.find_by_id(params[:id])

        if !task.nil?
          render json: {status: 'SUCCESS', message: 'Task loaded.', data: task}, status: :ok
        else
          render json: {status: 'SUCCESS', message: 'This task doesn\'t exist.'}, status: :ok
        end
      end

      def create
        task = Task.new(task_params)

        if task.save
          render json: {status: 'SUCCESS', message: 'Task created.', data: task}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Task not created.', data: task.errors}, status: :unprocessable_entity
        end
      end

      def update
        task = Task.find_by_id(task_params[:id])

        if task
          if task.update_attributes(task_params)
            render json: {status: 'SUCCESS', message: 'Task updated.', data: task}, status: :ok
          else
            render json: {status: 'ERROR', message: 'Task not updated.', data: task.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message: 'Task not found.'}, status: :unprocessable_entity
        end
      end

      def destroy
        task = Task.find_by_id(task_params[:id])

        if task
          if task.destroy
            render json: {status: 'SUCCESS', message: 'Task destroyed.', data: task}, status: :ok
          else
            render json: {status: 'ERROR', message: 'Task not destroyed.', data: task.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message: 'Task not found.'}, status: :unprocessable_entity
        end
      end

      private

      # Never trust parameters from the scary internet, only allow the white list through.
      def task_params
        params.permit(:title, :body, :status_id, :id)
      end
      
    end
  end
end