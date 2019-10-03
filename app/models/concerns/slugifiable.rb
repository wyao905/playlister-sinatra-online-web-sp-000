module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      all.each{|inst| return inst if inst.slug == slug}
    end
  end
  
  module InstanceMethods
    def slug
      self.name.downcase.split(" ").join("-")
    end
  end
end