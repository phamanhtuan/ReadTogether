class ArticleTagAssignment < ActiveRecord::Base
	belongs_to :article
	belongs_to :tag
end
