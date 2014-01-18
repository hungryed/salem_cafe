class PagesController < ApplicationController

  def index
    @food_item_1 = Food.picture_list.sample
    @food_item_2 = Food.picture_list.sample
    @food_item_3 = Food.picture_list.sample
    @food_item_4 = Food.picture_list.sample
    @food_items = [@food_item_1,
      @food_item_2,
      @food_item_3,
      @food_item_4]
    @food_items.delete(nil)
  end
end
