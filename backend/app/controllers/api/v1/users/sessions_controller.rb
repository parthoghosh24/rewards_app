module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        include RackSessionsFix
        respond_to :json

        def create
          user = User.find_by(email: params[:user][:email])
          if user&.valid_password?(params[:user][:password])
            sign_in(user)
            respond_with(user, {})
          else
            render_error(message: 'Invalid email or password' , code: "unauthorized", status: :unauthorized)
          end
        end

        private

        def respond_with(current_user, _opts = {})
          render_success(data: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
                           message: 'Logged in successfully.'  )
        end

        def respond_to_on_destroy
          if request.headers['Authorization'].present?
            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
            current_user = User.find(jwt_payload['sub'])
          end
          
          if current_user
            render_success(data: {},
                           message: 'Logged out successfully.'  )
          else
            render_error(message: "Couldn't find an active session." , code: "unauthorized", status: :unauthorized)
          end
        end
      end
    end
  end
end 