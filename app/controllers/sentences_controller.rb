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
		respond_with Sentence.destroy(params[:id])
	end
	private
    # permissible attributes.
	    def sentence_params
	      params.require(:sentences).permit(:content, :article_id, :paragraph, :position, :id)
	    end
end
