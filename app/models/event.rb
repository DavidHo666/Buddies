class Event < ApplicationRecord
  belongs_to :user
  has_many :participations
  has_many :users, through: :participations
  def self.all_tags
    %w[Food&Drink Arts&Culture Travel Movies Music Metraverse Academia Athletics Others]
  end

  def self.with_tags_sort(tags_list = [], sort_key)
    return Event.where(tag: tags_list).where("available_spots != 0").where("end_time > ?", Time.now).order(sort_key)
  end

  def self.search_events(search_by_name)
    return Event.where("event_name LIKE ?", "%#{search_by_name}%" ).where("available_spots != 0").where("end_time > ?", Time.now)
  end

  def self.search_time(search_by_time)
    return Event.where("start_time <= ? and end_time >= ?", "#{search_by_time} 23:59:59", "#{search_by_time} 00:00:00") 
    #time range
  end
end
