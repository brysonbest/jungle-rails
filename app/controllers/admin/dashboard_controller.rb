class Admin::DashboardController < ApplicationController
  user = ENV['USERNAME']
  pass = ENV['PASSWORD']


  http_basic_authenticate_with name: user, password: pass
  
  def show
  end
end
