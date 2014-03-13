require 'json'

module RandomTasks
	class Task
		attr_accessor :title, :time, :image

		def initialize(title, time = 10)
			@title = title
			@time = time
		end

		def to_json(options = {})
			{:title => @title, :time => @time, :image => @image}.to_json(options)
		end

		def self.from_hash(task)
			self::new(task['title'])
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

		def self.from_hash(image)
			self::new(image['url'], image['credits'])
		end
	end
end