class OrderTotalsController < ApplicationController
  def index
    if params[:q]
      binding.pry
      @orders = OrderTotal.new('', '')
    else
      @orders = OrderTotal.new('', '')
    end
  end
end
