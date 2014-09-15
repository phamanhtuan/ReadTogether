class Sentence < ActiveRecord::Base
	validates_presence_of :content
	has_many :comments, dependent: :destroy
	has_one :article
end
