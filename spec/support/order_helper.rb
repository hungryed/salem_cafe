module OrderHelper
  def create_order(options = {})
    section = options[:section]
    food = options[:food]
    arrival_time = options[:arrival_time]
    if section.nil?
      section = FactoryGirl.create(:section)
    end
    if food.nil?
      food_category = FactoryGirl.create(:food_category,
        section: section)
      food = FactoryGirl.create(:food,
        food_category: food_category,
        section: section)
    end
    if !arrival_time.nil?
      order = FactoryGirl.create(:order,
        arrival_time: arrival_time,
        section: section)
      order_food = FactoryGirl.create(:order_food,
        order: order,
        food: food)
      order_food.order
    else
      order = FactoryGirl.create(:order,
        section: section)
      order_food = FactoryGirl.create(:order_food,
        food: food,
        order: order)
      order_food.order
    end
  end
end
