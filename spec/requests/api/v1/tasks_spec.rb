# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let!(:update_task) { create(:task) }

  describe 'GET #index' do
    let!(:tasks) { create_list(:task, 3) }

    it 'returns a successful response' do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(4)
    end
  end

  describe 'GET #show' do
    let!(:task) { create(:task) }

    it 'returns a successful response' do
      get :show, params: { id: task.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(task.id)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          brand: 'Honda',
          car_model: 'Civic',
          price: 300,
          url: 'https://example.com/civic',
          status: 'available'
        }
      end

      it 'creates a new task and returns a created response' do
        expect do
          post :create, params: valid_params
        end.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['brand']).to eq('Honda')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the requested task' do
        put :update, params: { id: update_task.id, brand: 'Updated Brand', car_model: 'Updated Model' }
        update_task.reload

        expect(response).to have_http_status(:ok)
        updated_task = JSON.parse(response.body)

        expect(updated_task['brand']).to eq('Updated Brand')
        expect(updated_task['car_model']).to eq('Updated Model')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the task exists' do
      it 'deletes the task' do
        expect do
          delete :destroy, params: { id: update_task.id }
        end.to change(Task, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Task deleted successfully.')
      end
    end
  end
end
