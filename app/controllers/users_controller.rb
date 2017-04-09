# Users Controller
class UsersController < ApplicationController
  before_action only: [:show, :update, :destroy] do
    find_record(User)
  end

  def index
    users = User.all
    render Response::Success.new(users).response
  end

  def show
    render Response::Success.new(@record).response
  end

  def create
    user = User.new(user_params)
    if user.save
      render Response::Success.new(user).response
    else
      render Response::Error.new(user.errors.full_messages).response
    end
  end

  def update
    if @record.update(user_params)
      render Response::Success.new(@record).response
    else
      render Response::Error.new(@record.errors.full_messages).response
    end
  end

  def destroy
    @record.destroy
    render Response::Success.new('Successfully deleted user').response
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email)
  end
end
