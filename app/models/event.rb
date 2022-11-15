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

end
