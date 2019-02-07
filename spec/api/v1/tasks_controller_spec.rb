require 'rails_helper'
RSpec.describe Api::V1::TasksController do
  test_status = Status.find_or_create_by!(description: 'Test status')
  test_task = Task.find_or_create_by!(title: 'Test title', body: 'Test body', status: test_status )

  describe 'GET #index' do
    before do
      get '/api/v1/tasks'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'the JSON response should contain all tasks attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['data', 'message', 'status'])
    end
  end

  describe 'GET #tasks/id' do
    context 'given a valid object in the DB with id 1' do
      before do
        get '/api/v1/tasks/1'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'the JSON returned should be equal to the first object in the database' do
        json_response = JSON.parse(response.body)
        new_task = Task.new(json_response['data'])
        expect(new_task).to eql(Task.first)
      end
    end

    context 'given an object that doesn\'t exist in the DB with id -50' do
      before do
        get '/api/v1/tasks/-50'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'the JSON returned should not contain a data key' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['status', 'message'])
      end
    end
  end

  describe 'DELETE #tasks/1' do
    context 'given a valid object in the DB with id 1' do
      before do
        delete '/api/v1/tasks/1'
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'the JSON returned should be an object with the deleted flag set to true' do
        task = Task.find_by_id(1)
        expect(task).to eql(nil)
      end
    end

    context 'given an object that doesn\'t exist in the DB with id -50' do
      before do
        delete '/api/v1/tasks/-50'
      end

      it 'returns http unproccessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'the JSON returned should not contain a data key' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['status', 'message'])
      end
    end
  end

  describe 'UPDATE #tasks/1' do
    context 'given a valid update json' do
      it 'the JSON returned should be an object with the description that matches the params' do
        random_title = "Title #{rand(10...42)}"
        random_body = "Body #{rand(10...42)}"

        form_params = {
            title: random_title,
            body: random_body
        }
        patch '/api/v1/tasks/1', params: form_params

        expect(Task.first.title).to eql(random_title)
      end
    end

    context 'given an invalid update json' do
      it 'the response should contain an unproccessable entity status code' do

        form_params = {
          body: ''
        }
        patch '/api/v1/tasks/1', params: form_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'given a task that doesn\'t exist' do
      it 'the JSON returned should be an object with the description that matches the params' do

        form_params = {
            body: 'Some body'
        }
        patch '/api/v1/tasks/-50', params: form_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'CREATE #tasks' do
    context 'given a valid create json' do
      it 'the JSON returned should be an object that matches the params' do

        form_params = {
            title: "Some title",
            body: "Some body",
            status_id: Status.first.id
        }
        post '/api/v1/tasks', params: form_params

        json_response = JSON.parse(response.body)
        new_task = Task.new(json_response['data'])
        expect(new_task).to eql(Task.last)
      end
    end

    context 'given an invalid create json' do
      it 'the response should be invalid' do
        form_params = {
            title: "Some title",
            body: "",
            status_id: Status.first.id
        }
        post '/api/v1/tasks', params: form_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

end