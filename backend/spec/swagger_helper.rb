# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          Bearer: {
            description: 'JWT key necessary to use API calls',
            type: :apiKey,
            name: 'authorization',
            in: :header
          }
        },
        schemas:{
          reward_item: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              points: { type: :integer }
            },
            required: %w[id title points]
          },
          rewards_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/reward_item' }
              },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'rewards' }
            },
            required: %w[status data message]
          },
          user: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string, format: :email },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' },
              jti: { type: :string }
            },
            required: %w[id email created_at updated_at jti]
          },
          
          user_point: {
            type: :object,
            properties: {
              id: { type: :integer },
              user: { '$ref' => '#/components/schemas/user' },
              points: { type: :integer }
            },
            required: %w[id user points]
          },
          
          user_points_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: { '$ref' => '#/components/schemas/user_point' },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'user points' }
            },
            required: %w[status data message]
          },

          login_params: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  email: {
                    type: :string,
                    example: 'foo@example.com',
                  },
                  password: {
                    type: :string,
                    example: 'password',
                  }
                }
              }
            },
            required: ['user']
          },


          login_user: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string, format: :email }
            },
            required: %w[id email]
          },
          
          login_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: { '$ref' => '#/components/schemas/login_user' },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'Logged in successfully.' }
            },
            required: %w[status data message]
          },

          logout_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: {
                type: :object,
                description: 'Empty object since there is no additional data on successful logout'
              },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'Logged out successfully.' }
            },
            required: %w[status data message]
          },

          signup_params: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  email: {
                    type: :string,
                    example: 'foo@example.com',
                  },
                  password: {
                    type: :string,
                    example: 'password',
                  }
                }
              }
            },
            required: ['user']
          },

          signup_user: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string, format: :email }
            },
            required: %w[id email]
          },
          
          signup_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: { '$ref' => '#/components/schemas/signup_user' },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'Signed up successfully.' }
            },
            required: %w[status data message]
          },

          redemption_reward: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              points: { type: :integer },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: %w[id title points created_at updated_at]
          },
          
          redemption_item: {
            type: :object,
            properties: {
              id: { type: :integer },
              created_at: { type: :string, format: 'date-time' },
              reward: { '$ref' => '#/components/schemas/redemption_reward' }
            },
            required: %w[id created_at reward]
          },
          
          redemptions_response: {
            type: :object,
            properties: {
              status: { type: :string, example: 'success' },
              data: {
                type: :array,
                items: { '$ref' => '#/components/schemas/redemption_item' }
              },
              meta: {
                type: :object,
                description: 'Optional metadata, currently empty',
                nullable: true
              },
              message: { type: :string, example: 'redemptions' }
            },
            required: %w[status data message]
          },

          redeem_params: {
            type: :object,
            properties: {
              reward_id: {
                type: :integer,
                example: 1,
              }
            },
            required: ['reward_id']
          },
          redeem_response: {
            type: :object,
            properties: {
              data: {},
              message: {type: :string, example: 'redemption successful'}
            },
            required: %w[status data message]
          },

        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000/'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
