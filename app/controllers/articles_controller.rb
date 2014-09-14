class ArticlesController < ApplicationController
	respond_to :json

	def index		
		@articles = Article.all.order('updated_at DESC').paginate(:page => params[:page], :per_page =>7)		
		respond_to do |format|
            format.json { render json: {models: @articles, total: @articles.count, per_page: 7, page: params[:page] } }
        end
	end

	def show
		respond_with Comment.find(params[:id])
	end

	def create		
		@article = Article.create()	
		@tmp = 	article_params[:content].gsub(/\n+/, "\n")
		@paragraphs = @tmp.split("\n")
		paragraph_id=0
		@paragraphs.each do |paragraph|
			if paragraph_id == 0
				Sentence.create({paragraph: paragraph_id, position: 0, content: paragraph, article_id: @article.id})
			else
				position_id = 0
				sentences = paragraph.split(/(?<=[?.!])\s*/)
				sentences.each do |sentence|
					Sentence.create({paragraph: paragraph_id, position: position_id, content: sentence, article_id: @article.id})
					position_id = position_id +1
				end
			end
			paragraph_id = paragraph_id+1
		end 
		# @arr = (article_params[:content]).split(".")
		# i = 0
		# @arr.each do |el|
		# 	Sentence.create({paragraph: 1, position: i, content: el, article_id: @article.id})
		# 	i = i+1
		# end		
		respond_with @article
	end

	def update
		@sentence = Sentence.find(params[:sentence_id])
		@comment = Comment.find(params[:id]);
		@comment.update_attributes(comment_params)
		respond_with @sentence, @comment		
	end

	def destroy
		respond_with Article.destroy(params[:id])
	end
	private
    # permissible attributes.
	    def article_params
	      params.permit(:content)
	    end	
end
