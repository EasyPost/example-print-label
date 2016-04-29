module PrintLabel
  module Helpers

    def newer_pages?(obj)
      (obj.has_more && params['after_id']) ||
        params['before_id']
    end

    def older_pages?(obj)
      (obj.has_more && params['before_id']) ||
        params['after_id'] ||
        (!params['after_id'] && !params['before_id'] && obj.has_more)
    end

    def has_pages?(obj)
      newer_pages?(obj) ||
        older_pages?(obj)
    end

  end
end
