module EventsHelper
  # def is_hilite(the_key)
  #   if @sort_key == the_key
  #     return "hilite"
  #   end
  # end

  def flatten_date_array(hash, name)
    %w(1 2 3 4 5).map { |e| hash[name+"_time(#{e}i)"].to_i }
  end
end

