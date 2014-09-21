class Vocabulary < ActiveRecord::Base
	has_many :translations, dependent: :destroy
	validates_presence_of :word

	def as_json(params = {})
		super(include: [:translations])
	end
end
