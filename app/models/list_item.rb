class ListItem < ApplicationRecord
  belongs_to :list
  has_many :tag_items, dependent: :destroy
  has_many :tags, :through => :tag_items
  validates_presence_of :name
  act_as_fake_deletable
  scope :destroyed_items, -> { joins(:list).where('lists.deleted_at is null').where('list_items.deleted_at is not null') }
end
