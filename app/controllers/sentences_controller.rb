class SentencesController < ApplicationController
	respond_to :json

	def index
		article = Article.find(params[:article_id])
		respond_with article.sentences.as_json
	end

	def show
		respond_with Sentence.find(params[:id])
	end

	def create
		respond_with Sentence.create(sentence_params)
	end

	def update
		respond_with Sentence.find(params[:id]).update_attributes(sentence_params)
	end

	def destroy
		deleted_sentence = Sentence.find(params[:id])
		if(deleted_sentence[:paragraph] == 0 ) 
			respond_with deleted_sentence
		else
			@sentences = Sentence.where("article_id = ?", params[:article_id] ).where("paragraph > ?", deleted_sentence[:paragraph] )			
			@sentences_paragraph = Sentence.where("article_id = ?", params[:article_id] ).where("paragraph = ?", deleted_sentence[:paragraph] )
			if(@sentences_paragraph.count > 0)
				@sentences_paragraph.each do |sentence|
					if(sentence[:position]  > 0  )
						sentence.update_attributes(:position => sentence[:position] - 1) 
					end
				end
			else			
				@sentences.each do |sentence|
					if(sentence[:paragraph]  > 0  )
						sentence.update_attributes(:paragraph => sentence[:paragraph] - 1) 
					end
				end
			end
			
			respond_with Sentence.destroy(params[:id])
		end
	end
	private
    # permissible attributes.
	    def sentence_params
	      params.permit(:content, :article_id, :paragraph, :position, :id)
	    end
end
