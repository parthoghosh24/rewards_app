module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include RackSessionsFix
        respond_to :json
        

        private

        def sign_up_params
          params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end

        def respond_with(current_user, _opts = {})
          if current_user.persisted?
            render_success(data: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
                           message: 'Signed up successfully.', status: 201  )
          else
            render_error(message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}",
                         code: :unprocessable_entity,
                         status: :unprocessable_entity
                         )
          end
        end
      end
    end
  end
end 