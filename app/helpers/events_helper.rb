module EventsHelper
  def is_hilite(the_key)
    if @sort_key == the_key
      return "hilite"
    end
  end
end
