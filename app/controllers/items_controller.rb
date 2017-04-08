# Items Controller
class ItemsController < ApplicationController
  before_action only: [:show, :update, :destroy] do
    find_record(Item)
  end

  def index
    items = if params[:group_id]
              Group.find(params[:group_id]).items
            else
              User.find(params[:user_id]).items
            end

    render Response::Success.new(items).response
  end

  def show
    render Response::Success.new(@record).response
  end

  def create
    item = Item.new(item_params)
    if item.save
      render Response::Success.new(item).response
    else
      render Response::Error.new(item.errors.full_messages).response
    end
  end

  def update
    if @record.update(item_params)
      render Response::Success.new(@record).response
    else
      render Response::Error.new(@record.errors.full_messages).response
    end
  end

  def destroy
    @record.destroy
    render Response::Success.new('Successfully deleted item').response
  end

  private

  def item_params
    params.require(:item).permit(:name, :url, :price, :list_id)
  end
end
