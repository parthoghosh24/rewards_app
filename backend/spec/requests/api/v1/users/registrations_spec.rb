require 'swagger_helper'

RSpec.describe 'api/v1/signup', type: :request do

  path '/api/v1/signup' do
    post('signup user') do
      tags 'User Signup'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :signup_params, in: :body, required: true, schema: {'$ref' => '#/components/schemas/signup_params'}
      description 'registers user'
      response(201, 'successful') do
        schema '$ref' => '#/components/schemas/signup_response'

        
        let(:signup_params) {{user: { email: 'foo@example.com', password: 'password' }} }
        

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
