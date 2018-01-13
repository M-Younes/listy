class List < ApplicationRecord
  has_many :list_items, dependent: :destroy
  accepts_nested_attributes_for :list_items, allow_destroy: true, reject_if: :all_blank
  validates_presence_of :name	
  act_as_fake_deletable
end
