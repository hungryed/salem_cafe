module Seeders
  module Sections
    class << self
      def seed
        section_list.each do |section|
          Section.find_or_create_by(section)
        end
      end

      def section_list
        [
          {
            name: 'Grill',
            description: 'Hot Grilled Food',
            start_time: '11:00:00',
            end_time: '14:00:00'
          },
          {
            name: 'Deli',
            description: 'Hot or Cold Sandwiches',
            start_time: '11:00:00',
            end_time: '14:00:00'
          },
          {
            name: 'Hot Line',
            description: 'Delicious home-cooked meals',
            start_time: '11:00:00',
            end_time: '14:00:00'
          },
          {
            name: 'Breakfast',
            description: 'Early Morning Food',
            start_time: '7:00:00',
            end_time: '10:00:00'
          }
        ]
      end
    end
  end

  module FoodCategories
    class << self
      def make(section, name, description=nil)
        FoodCategory.find_or_create_by(section: section,
          name: name, description: description)
      end
    end
  end

  module Foods
    class << self
      def make(food_category, name, description=nil)
        Food.find_or_create_by(food_category: food_category,name: name,description: description)
      end
    end
  end
end
