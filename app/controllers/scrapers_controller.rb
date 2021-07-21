class ScrapersController < ApplicationController
    def create
        response = HTTParty.get('https://vnexpress.net/thoi-su')
        doc = Nokogiri::HTML(response.body)
        # puts doc

        # # Find the first h1 tag
        titles = doc.css("h3.title_news > a[href]")

        # # Get the text-content
        titles.each do |title|
            print title.content
            # @post = Post.new(user_id: 1, title: title)
            # @post.save!
        end
    end
end
