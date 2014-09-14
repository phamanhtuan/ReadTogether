class Article < ActiveRecord::Base
	has_many :sentences, dependent: :destroy
	self.per_page = 5
end
