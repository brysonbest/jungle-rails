class Admin::DashboardController < ApplicationController
  user = ENV['USERNAME']
  pass = ENV['PASSWORD']


  http_basic_authenticate_with name: user, password: pass
  
  def show
    @category = Category.find_each()
    @categories = []
    @category.each do |each|
      products = each.products.order(created_at: :desc)
      count = 0
      products.each do |prod|
        count += prod.quantity
      end
      cat = [each.name, count]
      @categories.push(cat)
    end
    @product_totals = []
    @category.each do |items|
      products = items.products.order(created_at: :desc)
      @product_totals.push(products)
    end

  end
end
