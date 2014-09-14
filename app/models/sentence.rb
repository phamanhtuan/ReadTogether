class Sentence < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_one :article
end
