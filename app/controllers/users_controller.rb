class UsersController < Clearance::UsersController
# before_action :set_photo, only: [:show, :edit, :update, :destroy]
# before_action :require_login

# def create
#   @user = user_from_params
#   byebug
#   if @user.save
#     sign_in @user
#     redirect_back_or url_after_create
#   else
#     render template: "users/new"
#   end
# end

  def edit

    @user = current_user

  end

  def show

    @user = current_user

  end

  def update

    @user = current_user
    # @user.update(:first_name => params[:first_name], :last_name => params[:last_name])
    @user.image = params[:user][:image]
      # if @user.save
      #
      #   flash[:success] = "Changes saved successfully."
      #
      # else
      #
      #   flash[:error] = "Changes could not be captured."
      # end

  end


private


# Use callbacks to share common setup or constraints between actions.
# def set_photo
#   @photo = Photo.find(params[:id])
# end

  def user_from_params
    # byebug
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    image = user_params.delete(:image)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.image = user_params.delete(:image)
    end
  end

  def user_params
    params.require(:user).permit(:email,:password,:first_name,:last_name,:image)
  end

end
