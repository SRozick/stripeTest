module ApplicationHelper

# Credit for title and meta_description helpers to David Lesches at
# http://davidlesches.com/blog/elegant-titles-and-seo-meta-tags-in-rails
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) + ' | ' +  APP_CONFIG['default_title'] : APP_CONFIG['default_title']
    end #if
  end #title

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['default_desc']
    end #if
  end #title

  def canonical(canonical = nil)
    if canonical.present?
      content_for :canonical, canonical
    else
      content_for?(:canonical) ? content_for(:canonical) : APP_CONFIG['default_canonical']
    end #if
  end #title

end
