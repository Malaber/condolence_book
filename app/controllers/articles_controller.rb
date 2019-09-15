class ArticlesController < ApplicationController

  def new
    render 'articles/new'
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def show
    @article = Article.find(params[:id])
    render 'articles/show'
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :tag, :email)
  end
end
