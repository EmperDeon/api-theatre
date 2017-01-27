class ArticlesController < ResourceController
    MODEL_CLASS = ::Article

    def create_action
        article = Article.new(post_params)
        article.theatre_id = @current_user.theatre_id
        article.save!
    end
end
