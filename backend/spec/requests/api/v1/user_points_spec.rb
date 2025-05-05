require 'swagger_helper'

RSpec.describe 'api/v1/user_points', type: :request do

  path '/api/v1/user_points' do
    get('return user\'s points') do
      tags 'Get User points'
      consumes 'application/json'
      produces 'application/json'
      description 'Fetch user\'s points'
      security [Bearer: []]
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/user_points_response'

        let!(:user) { User.create!(email: "foo@example.com", password: "password") }

        let(:authorization) do
          post '/api/v1/login', params: { user: { email: user.email, password: 'password' } }
          token = response.headers['authorization']
          raise 'JWT not returned from login' unless token
          token
        end

        before do |example|
          # Call the endpoint with Authorization header
          get '/api/v1/user_points', headers: { 'Authorization' => authorization }
        end

        after do |example|
          content = example.metadata[:response][:content] || {}
          example_spec = {
            "application/json" => {
              examples: {
                test_example: {
                  value: JSON.parse(response.body, symbolize_names: true)
                }
              }
            }
          }
          example.metadata[:response][:content] = content.deep_merge(example_spec)
        end

        run_test!
      end
    end
  end
end
