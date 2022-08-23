class ApplicationController < ActionController::Base
  def set_order_vars
    @order_column ||= params.fetch(:order_column, :id)
    @order_direction ||= params.fetch(:order_direction, :desc)
  end

  def authenticate!
    redirect_to user_session_path unless user_signed_in?
  end
end
