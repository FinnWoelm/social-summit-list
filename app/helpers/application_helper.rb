module ApplicationHelper
  # from http://stackoverflow.com/questions/5012188/rails-link-to-external-site-url-is-attribute-of-user-table-like-users-websit
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end
