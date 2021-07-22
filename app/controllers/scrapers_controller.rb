class ScrapersController < ApplicationController
    def get_data_vnexpress
        response = HTTParty.get('https://vnexpress.net/goc-nhin')
        doc = Nokogiri::HTML(response.body)
        
        # Get block
        processing_block = doc.css("h3.title-news")

        # Create data in array
        data = Struct.new(:title, :link)
        processing_datas = []
        processing_block.each do |processing_block|
            title = processing_block.css("a").map { |title| title['title']}
            link = processing_block.css("a").map { |link| link['href']}
            data_temp = data.new(title.first, link.first)
            processing_datas.push(data_temp)
        end
        return processing_datas
    end

    def get_data_kenh14
        response = HTTParty.get('https://kenh14.vn/xa-hoi.chn')
        doc = Nokogiri::HTML(response.body)
        
        # Get block
        processing_block = doc.css("li.ktncli")

        # Create data in array
        data = Struct.new(:title, :link)
        processing_datas = []
        processing_block.each do |processing_block|
            title = processing_block.css("a").map { |title| title['title']}
            link = processing_block.css("a").map { |link| link['href']}
            data_temp = data.new(title.first, "https://kenh14.vn" + link.first)
            processing_datas.push(data_temp)
        end
        return processing_datas
    end

    def create
        processing_datas = get_data_kenh14
        # Create new modal
        processing_datas.first(2).each do |processing_data|
            @post = Post.new
            @post.title = processing_data.title
            @post.link = processing_data.link
            @post.user_id = 1

            if @post.save
                # Create topic
                @post_topping = @post.topings.build(:topic_id => 1)
                @post_topping.save!
                
                # Create link
                @post_link = @post.post_links.build
                @link = LinkThumbnailer.generate(@post.link)
                if @link.present?
                    image = ""
                    favicon = ""
                    title = ""
                    description = ""

                    if !@link.images.first.nil?
                        image = @link.images.first.src.to_s
                    end
                    if !@link.favicon.nil?
                        favicon = @link.favicon.to_s
                    end
                    if @link.title.present?
                        title = @link.title
                    end
                    if @link.description.present?
                        description = @link.description
                    end

                    @post_link = @post.post_links.create!(:image => image,
                                                            :favicon => favicon,
                                                            :title => title,
                                                            :description => description,
                                                            :post_id => @post.id)
                end
            end
        end
    end
end
