class Post

	include DataMapper::Resource

	property :id, Serial

	has n, :peeps, :through => Resource

end