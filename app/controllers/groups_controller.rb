# Groups controller
class GroupsController < ApplicationController
  before_action only: [:show, :update, :destroy] do
    find_record(Group)
  end

  def index
    groups = Group.all
    render Response::Success.new(groups).response
  end

  def show
    render Response::Success.new(@record).response
  end

  def create
    group = Group.new(group_params)
    if group.save
      render Response::Success.new(group).response
    else
      render Response::Error.new(group.errors.full_messages).response
    end
  end

  def update
    if @record.update(group_params)
      render Response::Success.new(@record).response
    else
      render Response::Error.new(@record.errors.full_messages).response
    end
  end

  def destroy
    @record.destroy
    render Response::Success.new('Successfully deleted group').response
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
