class ArticlesController < ApplicationController
	respond_to :json

	def index	
		tag = params[:tag]
		if tag == nil	
			@articles = Article.all.order('updated_at DESC').paginate(:page => params[:page], :per_page =>7)	
		else 			
			@articles =  Article.includes(:article_tag_assignments=> :tag).where('tags.title' =>URI.decode(tag)).order('articles.updated_at DESC').paginate(:page => params[:page], :per_page =>7)
		end
		respond_to do |format|
            format.json { render json: {models: @articles.as_json, total: @articles.count, per_page: 7, page: params[:page] } }
        end
	end

	def show
		respond_with Article.find(params[:id])
	end

	def create		
		@article = Article.create()	
		tags = params[:tags]
		result = false
		@article.transaction do
			create_tags(@article[:id], tags)
			result = create_sentences(@article[:id], params[:content])
		end	
		if result
			respond_with @article
		else
			respond_to do |format|
	            format.json { render json: result, status: :unprocessable_entity }
	        end		
    	end
		# @tmp = 	article_params[:content].gsub(/\n+/, "\n")
		# @paragraphs = @tmp.split("\n")
		# paragraph_id=0
		# @paragraphs.each do |paragraph|
		# 	if paragraph_id == 0
		# 		Sentence.create({paragraph: paragraph_id, position: 0, content: paragraph, article_id: @article.id})
		# 	else
		# 		position_id = 0
		# 		sentences = paragraph.split(/(?<=[?.!])\s*/)
		# 		sentences.each do |sentence|
		# 			Sentence.create({paragraph: paragraph_id, position: position_id, content: sentence, article_id: @article.id})
		# 			position_id = position_id +1
		# 		end
		# 	end
		# 	paragraph_id = paragraph_id+1
		# end 
		# @arr = (article_params[:content]).split(".")
		# i = 0
		# @arr.each do |el|
		# 	Sentence.create({paragraph: 1, position: i, content: el, article_id: @article.id})
		# 	i = i+1
		# end		
		# respond_with @article
	end

	def update
		@article = Article.find(params[:id])			
		sentences_old = @article.sentences.collect{|x| x[:id]}
		tags = params[:tags]
		result = false
		@article.transaction do
			create_tags(@article[:id], tags)
			result = create_sentences(@article[:id], params[:content])
		end				
		if result
			sentences_old.each do |sentence|
				Sentence.find(sentence).destroy()
			end
			respond_with result
		else
			respond_to do |format|
	            format.json { render json: result, status: :unprocessable_entity }
	        end		
    	end
	end

	def destroy
		respond_with Article.destroy(params[:id])
	end
	private
    # permissible attributes.
	    def article_params
	      params.permit(:content)
	    end	
		def create_sentences(article_id, content)
			tmp = 	content.gsub(/\n+/, "\n")
			if tmp.length == 0 
				return false
			end
			paragraphs = tmp.split("\n")
			paragraph_id=0
			paragraphs.each do |paragraph|
				if paragraph_id == 0
					Sentence.create({paragraph: paragraph_id, position: 0, content: paragraph, article_id: article_id})
				else
					position_id = 0
					sentences = paragraph.split(/(?<=[?.!])\s*/)
					sentences.each do |sentence|
						Sentence.create({paragraph: paragraph_id, position: position_id, content: sentence, article_id: article_id})
						position_id = position_id +1
					end
				end
				paragraph_id = paragraph_id+1
			end 
		end
		def create_tags(article_id, tags)			
			if tags.length == 0 
				Article.find(article_id).article_tag_assignments.destroy_all 
				return true
			end
			tags_arr = tags.split("||")
			if	tags_arr.length == 0
				Article.find(article_id).article_tag_assignments.destroy_all 
				return true
			end	
			Article.find(article_id).article_tag_assignments.destroy_all 
			tags_arr.each do |tag|
				if(Tag.find_by_title(tag)  == nil)
					Tag.create(title: tag )
				end
				Article.find(article_id).tags << Tag.find_by_title(tag)
			end
			
		end
end
