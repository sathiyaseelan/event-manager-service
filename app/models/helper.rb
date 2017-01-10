module Helper
  module Pagination
    def paginated_result(order: 'asc',sort_column: '_id',size: 10,page_num: 1)
      if order == 'asc'
        self.all.asc(sort_column).skip(size * (page_num - 1 )).limit(size)
      else
        self.all.desc(sort_column).skip(size * (page_num - 1 )).limit(size)
      end
    end

    def self.included(base)
        base.extend self
    end
  end
end
