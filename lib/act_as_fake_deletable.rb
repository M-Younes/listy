module ActAsFakeDeletable

  # override the model actions
  def delete
    self.delete_attributes
  end 

  def undelete # to "restore" the file
    self.undelete_attributes
  end
  # define new scopes
  def self.included(base)
    base.class_eval do
    	scope :not_destroyed, -> {where("(deleted_at IS NULL)")}
      scope :destroyed, -> {where("(deleted_at IS NOT NULL)")}
    end
  end

  def delete_attributes
    return self.deleted_at unless defined? (self.deleted_at)
    self.update_attributes(deleted_at: DateTime.current)
    self.delete_associated_attributes
  end

  def delete_associated_attributes
    self.class.reflections.select{|association_name, reflection| reflection.macro == :has_many && reflection.options[:dependent] == :destroy}.each do |associations|
      self.send(associations.first).each{|association| association.delete }
    end
  end

  def undelete_attributes
    return self.deleted_at unless defined? (self.deleted_at)
    self.update_attributes(deleted_at: nil)
    self.undelete_associated_attributes
  end

  def undelete_associated_attributes
    self.class.reflections.select{|association_name, reflection| reflection.macro == :has_many && reflection.options[:dependent] == :destroy}.each do |associations|
      self.send(associations.first).each{|association| association.undelete }
    end
  end  

end