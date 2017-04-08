# Lists Controller
class ListsController < ApplicationController
  before_action only: [:show, :update, :destroy] do
    find_record(List)
  end

  def index
    lists = if params[:group_id]
              Group.find(params[:group_id]).lists
            else
              User.find(params[:user_id]).lists
            end

    render Response::Success.new(lists).response
  end

  def show
    render Response::Success.new(@record).response
  end

  def create
    list = List.new(list_params)
    if list.save
      render Response::Success.new(list).response
    else
      render Response::Error.new(list.errors.full_messages).response
    end
  end

  def update
    if @record.update(list_params)
      render Response::Success.new(@record).response
    else
      render Response::Error.new(@record.errors.full_messages).response
    end
  end

  def destroy
    @record.destroy
    render Response::Success.new('Successfully deleted list').response
  end

  private

  def list_params
    params.require(:list).permit(:group_id, :user_id)
  end
end
