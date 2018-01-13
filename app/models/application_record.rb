class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.act_as_fake_deletable(options = {})
    alias_method :delete!, :delete
    include ActAsFakeDeletable
  end  
end
