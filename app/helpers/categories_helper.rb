module CategoriesHelper

  def get_all_categories
    categories = []
    $redis.hgetall(:categories).each do |cat|
      categories << { cat.first => cat.last }
    end
    categories
  end

  def add_to_categories(category)
    $redis.hset :categories, category.id, category.name
  end
end
