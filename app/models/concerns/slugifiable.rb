module Slugifiable
  module InstanceMethods

    def name
      "#{self.firstname} #{self.lastname}"
    end

    def slug
      self.name.gsub(" ", "-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
end
