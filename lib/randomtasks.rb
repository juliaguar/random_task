require 'json'

module RandomTasks
	class Task
		attr_accessor :title, :time

		def initialize(title, good, time = 10)
			@title = title
			@time = time
			@good = good
		end

		def to_json
			{:title => @title, :time => @time}.to_json
		end
	end
end