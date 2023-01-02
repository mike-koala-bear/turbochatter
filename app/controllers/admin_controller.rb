# frozen_string_literal: true

class AdminController < ApplicationController
  include AdminHelper
  def dashboard
    if current_user&.admin? || current_user&.owner?
      @messages = Message.messages_this_month
    else
      redirect_to root_path
    end
  end
end
