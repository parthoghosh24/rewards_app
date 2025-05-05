require 'swagger_helper'

RSpec.describe 'api/v1/redemptions', type: :request do

  path '/api/v1/redemptions' do

    get('list redemptions') do
      tags 'List Redemptions'
      consumes 'application/json'
      produces 'application/json'
      description 'List all redemptions in the system for the user'
      security [Bearer: []]
      pending response(200, 'successful') do
        schema '$ref' => '#/components/schemas/redemptions_response'

        let!(:user) { User.create!(email: "foo@example.com", password: "password") }

        reward_list = [
          {title: "Playstation 5",
          points: 2000},
          {title: "Xbox One",
          points: 1800},
          {title: "Nintendo Switch",
          points: 1000},
          {title: "Meta Oculus Quest 3",
          points: 1500},
          {title: "Book",
          points: 1000},
          {title: "Shoes",
          points: 500},
          {title: "Gift card",
          points: 100},
          {title: "Poster",
          points: 80},
          {title: "Toaster",
          points: 50},
          {title: "Socks",
          points: 20}
        ]

        reward_list.each do |reward|
          Reward.create(reward)
        end


        let!(:redemption1) { RedeemPoints.call(user: user, reward_id: 1)}
        let!(:redemption2) { RedeemPoints.call(user: user, reward_id: 2)}

        let(:authorization) do
          post '/api/v1/login', params: { user: { email: user.email, password: 'password' } }
          token = response.headers['authorization']
          raise 'JWT not returned from login' unless token
          token
        end

        before do |example|
          # Call the endpoint with Authorization header
          get '/api/v1/redemptions', headers: { 'Authorization' => authorization }
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

    post('redeem points') do
      tags 'Redeem points'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :redeem_params, in: :body, required: true, schema: {'$ref' => '#/components/schemas/redeem_params'}
      description 'Redeem user\'s points'
      security [Bearer: []]
      pending response(201, 'successful') do

        schema '$ref' => '#/components/schemas/redeem_response'

        reward_list = [
          {title: "Playstation 5",
          points: 2000},
          {title: "Xbox One",
          points: 1800},
          {title: "Nintendo Switch",
          points: 1000}]


        reward_list.each do |reward|
          Reward.create!(reward)
        end

        let(:redeem_params) {{reward_id: Reward.find_by(title: "Playstation 5").id} }

        let!(:user) { User.create!(email: "foo@example.com", password: "password") }

        let(:authorization) do
          post '/api/v1/login', params: { user: { email: user.email, password: 'password' } }
          token = response.headers['authorization']
          raise 'JWT not returned from login' unless token
          token
        end

        before do |example|
          # Call the endpoint with Authorization header
          post '/api/v1/redemptions', params: redeem_params, headers: { 'Authorization' => authorization }
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

