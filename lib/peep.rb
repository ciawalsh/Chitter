class Peep

	include DataMapper::Resource

	property :id, Serial
	property :body, Text
	property :time_stamp, DateTime	

	belongs_to :user

end