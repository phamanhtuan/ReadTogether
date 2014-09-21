class VocabulariesController < ApplicationController
	respond_to :json

	def index
		@sentence = Sentence.find(params[:sentence_id])
		words = @sentence[:content].tr('?!.', '').split(' ')
		@vocabularies = Vocabulary.where(:word => words)
		respond_with @vocabularies.as_json()
	end

	def show
		respond_with Vocabulary.find(params[:id])
	end

	def create		
		word = params[:word]
		meaning = params[:meaning]
		
		if(Vocabulary.find_by_word(word) == nil )
			@vocab = Vocabulary.create(word: word)
		else
			@vocab = Vocabulary.find_by_word(word)
		end
		if(@vocab.translations.find_by_meaning(meaning) == nil)
			Translation.create(meaning: meaning, vocabulary: @vocab)
		end
		respond_with  @vocab 	
	end

	def update
		@article = Article.find(params[:article_id])
		@sentence = Sentence.find(params[:sentence_id])
		@comment = Comment.find(params[:id]);
		@comment.update_attributes(comment_params)
		respond_with @article,@sentence, @comment		
	end

	def destroy
		respond_with Comment.destroy(params[:id])
	end
	private
    # permissible attributes.
	    def vocabulary_params
	      params.permit(:word, :id, :meaning)
	    end	
end
