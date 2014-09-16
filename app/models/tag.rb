class Tag < ActiveRecord::Base
	validates_presence_of :title
	has_many :article_tag_assignments, dependent: :destroy
	has_many :articles, through: :article_tag_assignments
end
