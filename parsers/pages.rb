nokogiri = Nokogiri.HTML(content)

noko_title = nokogiri.at('title')
title = noko_title.text unless noko_title.nil? 

current_uri = URI(page['url'])

outputs << {
      _collection: 'pages',
      _id: page['gid'],
      url: page['url'],
      title: title
}


# get the group of links
links = nokogiri.css('a')

# loop through the links
links.each do |link|

    if link['href'].nil?
      next
    end

    begin
      uri = URI(link['href'])
    rescue URI::InvalidURIError
      next
    end

    # if relative url then add the proper host
    if uri.host.nil?
      uri.host = current_uri.host
      uri.scheme = current_uri.scheme
    end

    # only enqueue the same host
    if uri.host == current_uri.host
      pages << {
          url: uri.to_s,
          page_type: 'pages',
        }
    else
      outputs << {
        _collection: 'external_links',
        url: uri.to_s
      }
    end
end
