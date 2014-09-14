class CommentsController < ApplicationController
	respond_to :json

	def index

		@article = Article.find(params[:article_id])
		@sentence = Sentence.find(params[:sentence_id])
		@comments = @sentence.comments.order('updated_at DESC').paginate(:page => params[:page], :per_page =>7)
	 	respond_to do |format|
            format.json { render json: {models: @comments, total: @sentence.comments.count, per_page: 7, page: params[:page] } }
        end
		# respond_with { render json: @comments, location: [@article, @sentence] }
	end

	def show
		respond_with Comment.find(params[:id])
	end

	def create		
		@article = Article.find(params[:article_id])
		@sentence = Sentence.find(params[:sentence_id])
		respond_with @article, @sentence, Comment.create(comment_params)	
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
	    def comment_params
	      params.require(:comment).permit(:content, :sentence_id, :id)
	    end	
end
