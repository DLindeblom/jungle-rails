class Admin::DashboardController < ApplicationController

  include HttpAuthConcern

  http_basic_authenticate_with name: 'jungle', password: 'book'
  
  def show
    @num_of_products = Product.count
    @num_of_categories = Category.count
  end
end
