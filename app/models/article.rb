class Article < ActiveRecord::Base
	has_many :sentences, dependent: :destroy
	has_many :article_tag_assignments, dependent: :destroy
	has_many :tags, through: :article_tag_assignments
	self.per_page = 5

	def as_json(params = {})
		super(include: [:tags, :sentences])
	end
end
