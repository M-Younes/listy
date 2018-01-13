class TagItem < ApplicationRecord
  belongs_to :list_item
  belongs_to :tag
  act_as_fake_deletable
  scope :destroyed_items, -> { joins(:list_item).where('list_items.deleted_at is null').where('tag_items.deleted_at is not null') }
end
