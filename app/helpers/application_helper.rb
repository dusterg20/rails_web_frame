module ApplicationHelper

  def edit_icon
    octicon("pencil", :height => 20, :"aria-label" => "Edit", :class => "text-right")
  end

  def add_icon
    octicon("plus", :height => 20, :"aria-label" => "Edit", :class => "text-right")
  end

  def delete_icon
    octicon("x", :height => 20, :"aria-label" => "Delete", :class => "octicon-alert text-right")
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Home Automation App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def human_boolean(boolean)
      boolean ? 'Yes' : 'No'
  end

end
