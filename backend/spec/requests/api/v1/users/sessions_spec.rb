require 'swagger_helper'

RSpec.describe 'api/v1/login', type: :request do

  path '/api/v1/login' do
    post('Login user') do
      tags 'User Login'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :login_params, in: :body, required: true, schema: {'$ref' => '#/components/schemas/login_params'}
      description 'Logs in user'
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/login_response'

        
        let(:login_params) {{user: { email: 'foo@example.com', password: 'password' }} }
        
        let!(:user) {User.create!(email: 'foo@example.com', password: 'password')}


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


RSpec.describe 'api/v1/logout', type: :request do

  path '/api/v1/logout' do
    delete('Logout user') do
      tags 'User Logout'
      produces 'application/json'
      consumes 'application/json'
      description 'Logs out user'
      pending response(200, 'successful') do
        schema '$ref' => '#/components/schemas/logout_response'

        
        let!(:user) {User.create!(email: 'foo@example.com', password: 'password')}


        before do |example|
          post '/api/v1/login', params: { user: { email: user.email, password: 'password' } }
          token = response.headers['authorization']
          raise 'JWT not returned from login' unless token
          # Call the endpoint with Authorization header
          delete '/api/v1/logout', headers: { 'Authorization' => token }
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
