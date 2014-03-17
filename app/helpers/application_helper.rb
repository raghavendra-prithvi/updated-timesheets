module ApplicationHelper

  # Returns the full title on a per-page basis in the browser
  def full_title(page_title)
    base_title = "MusicFeed"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
    # Returns the title on a per-page basis on the page
  def infull_title(inpage_title)
    if !inpage_title.empty?
      "#{inpage_title}"
    end
  end
  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
  end

end
