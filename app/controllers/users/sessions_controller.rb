# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_out_path_for(_resource_or_scope)
    user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    buying_groups_path
  end
end