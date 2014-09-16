class TagsController < ApplicationController
	respond_to :json

	def index
		respond_with Tag.all.to_json(:include => :articles)
	end

	# def show
	# 	respond_with Comment.find(params[:id])
	# end

	# def create		
	# 	@article = Article.find(params[:article_id])
	# 	@sentence = Sentence.find(params[:sentence_id])
	# 	respond_with @article, @sentence, Comment.create(comment_params)	
	# end

	# def update
	# 	@article = Article.find(params[:article_id])
	# 	@sentence = Sentence.find(params[:sentence_id])
	# 	@comment = Comment.find(params[:id]);
	# 	@comment.update_attributes(comment_params)
	# 	respond_with @article,@sentence, @comment		
	# end

	# def destroy
	# 	respond_with Comment.destroy(params[:id])
	# end
	private
    # permissible attributes.
	    def comment_params
	      params.require(:comment).permit(:content, :sentence_id, :id)
	    end	
end
