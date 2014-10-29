module ApplicationHelper

# Partial credit for title and meta_description helpers to David Lesches at
# http://davidlesches.com/blog/elegant-titles-and-seo-meta-tags-in-rails
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      if APP_CONFIG['default_title'] == nil
        default = APP_CONFIG['brand_name']
      else
        default = APP_CONFIG['default_title']
      end #if
      content_for?(:title) ? content_for(:title) + ' | ' +  default : default
    end #if
  end #title


  def company(company = nil)
    if company.present?
      content_for :company, company
    else
      if APP_CONFIG['company_name'] == nil
        default = APP_CONFIG['brand_name']
      else
        default = APP_CONFIG['company_name']
      end #if
      content_for?(:company) ? content_for(:company) + ' | ' +  default : default
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

  def bkg_start(bkg_start = nil)
    if bkg_start.present?
      content_for :bkg_start, bkg_start
    else content_for?(:bkg_start) ? content_for(:bkg_start) : ""
    end
  end #bkg_start

end
