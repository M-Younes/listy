module ActAsFakeDeletable

  # override the model actions
  def delete
    self.update_attributes(deleted_at: DateTime.current)
    self.list_items.each{|list_item| list_item.delete } if self.class.name == "List"
    self.tag_items.update_all(deleted_at: DateTime.current) if self.class.name == "ListItem"
  end 

  def undelete # to "restore" the file
    self.update_attributes(deleted_at: nil)
    self.list_items.each{|list_item| list_item.undelete } if self.class.name == "List"
    self.tag_items.update_all(deleted_at: nil) if self.class.name == "ListItem"
  end
  # define new scopes
  def self.included(base)
    base.class_eval do
    	scope :not_destroyed, -> {where("(deleted_at IS NULL)")}
      scope :destroyed, -> {where("(deleted_at IS NOT NULL)")}
    end
  end

end