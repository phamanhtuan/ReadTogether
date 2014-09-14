class Comment < ActiveRecord::Base
	validates_presence_of :content
	has_one :sentence
	self.per_page = 5
end
