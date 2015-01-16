class Peep

	include DataMapper::Resource

	has 1, :user, :through => Resource

	property :id, Serial
	property :body, Text
	property :time_stamp, DateTime	

end