# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @dashboard = DashboardService.new.call
  end

  def show
  end
end
