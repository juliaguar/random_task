require 'json'
require 'mongo'
require 'uri'
require 'yaml'

module RandomTasks
	class Storage
		attr_accessor :connection

		def initialize(db_uri)
			db = URI.parse(db_uri)
			db_name = db.path.gsub(/^\//, '')
			@connection = Mongo::Connection.new(db.host, db.port).db(db_name)
			@connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
		end

		def get_collection(name)
			@connection.collection(name)
		end
	end

	class Collection

		def initialize(class_type, collection_name)
			@collection_name = collection_name
			@class_type = class_type
			@collection = @@storage.get_collection(@collection_name)
		end

		def self.set_storage(storage)
			@@storage = storage
		end

		def get_all
			records = []
			@collection.find.each do |row|
				records << @class_type::from_hash(row)
			end
			records
		end

		def get_random
			total = @collection.count
			skip = if total > 1 then Random.rand(total) else 0 end
			raw = @collection.find_one({}, {
				:skip =>  skip
			})
			@class_type::from_hash(raw)
		end
	end

	class Task
		attr_accessor :title, :time, :image

		@@collection_name = 'tasks'

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

		@@collection_name = 'images'

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