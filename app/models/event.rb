class Event < ApplicationRecord
  def self.all_tags
    %w[Food&Drink Arts&Culture Travel Movies Music Metraverse Academia Athletics Others]
  end

  def self.with_tags_sort(tags_list = [], sort_key)
    if tags_list.empty?
      return Event.all.order(sort_key)
    else
      return Event.where(tag: tags_list).order(sort_key)
    end
  end

end
