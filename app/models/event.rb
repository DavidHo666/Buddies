class Event < ApplicationRecord
  belongs_to :user
  def self.all_tags
    %w[Food&Drink Arts&Culture Travel Movies Music Metraverse Academia Athletics Others]
  end

  def self.with_tags_sort(tags_list = [], sort_key)
    return Event.where(tag: tags_list).order(sort_key)
  end

end
