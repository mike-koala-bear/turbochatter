# frozen_string_literal: true

class VersionsController < ApplicationController
  def index
    @current_version = '1.2.7'
  end
end
