module LayoutHelper
  def title(page_title=nil, show_title = true)
    content_for(:title) { h('Reminderfy - '+page_title.to_s) } unless page_title.nil?
  end

  def stylesheet(*args)
    content_for(:stylesheets) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:javascript) { javascript_include_tag(*args) }
  end
end