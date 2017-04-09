# Base controller
class ApplicationController < ActionController::API
  private

  def find_record(table)
    @record = table.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render Response::Error.new("#{table} not found").response
  end
end
