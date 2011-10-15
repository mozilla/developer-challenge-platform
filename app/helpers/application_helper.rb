module ApplicationHelper
  def gravatar_for(email, options={})
    size = options.delete(:size) || 48
    options.merge!(:width => size, :height => size, :alt => 'Gravatar Image')
    image_tag "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size}&d=identicon&r=PG", options
  end
  
  def markdown(content)
    RDiscount.new(content).to_html
  end
end
