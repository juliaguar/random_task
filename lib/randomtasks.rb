require 'json'

module RandomTasks
	class Task
		attr_accessor :title, :time, :image

		def initialize(title, good, time = 10)
			@title = title
			@time = time
			@good = good
		end

		def to_json(options = {})
			{:title => @title, :time => @time, :image => @image}.to_json(options)
		end
	end

	class BackgroundImage
		attr_accessor :url, :credits

		def initialize(url, credits)
			@url = url
			@credits = credits
		end

		def to_json(options = {})
			{:url => @url, :credits => @credits}.to_json(options)
		end

		def self.random
			images = BackgroundImages::load_all()
			images.sample
		end
	end

	class BackgroundImages

		def initialize(background_images)
			@images = background_images
		end

		def sample
			@images.sample
		end

		def self.load_all
			images = []
			halfrain_credits = '<a href="http://creativecommons.org/licenses/by-sa/2.0/" title="Attribution-ShareAlike License">cc-by-sa</a> by <a href="http://www.flickr.com/photos/halfrain/">halfrain</a>'
			images << BackgroundImage::new('http://farm5.staticflickr.com/4113/5078240014_cf747d41ef_o.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm5.staticflickr.com/4019/5078240448_b908bbb89e_o.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm8.staticflickr.com/7165/6459391267_d97502c4f7_o.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm9.staticflickr.com/8244/8651612579_8c0e4dede7_k.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm5.staticflickr.com/4108/5077645173_afc0c0a6c3_o.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm5.staticflickr.com/4089/5191751684_f6d177b2a0_o.jpg', halfrain_credits)
			images << BackgroundImage::new('http://farm5.staticflickr.com/4084/5033107024_b2307df42b_o.jpg', halfrain_credits)

			cobaltfish_credits = '<a href="http://creativecommons.org/licenses/by-sa/2.0/" title="Attribution-ShareAlike License">cc-by-sa</a> by <a href="http://www.flickr.com/photos/cobaltfish/">cobaltfish</a>'
			images << BackgroundImage::new('http://farm8.staticflickr.com/7236/7304720350_0c64e0c6d6_h.jpg', cobaltfish_credits)

			BackgroundImages::new(images)
		end

	end
end