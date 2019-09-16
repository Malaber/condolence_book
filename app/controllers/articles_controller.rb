class ArticlesController < ApplicationController

  def new
    render 'articles/new'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      UserMailer.email_confirmation(@article).deliver
      flash[:success] = "Bitte bestätige deine E-Mail Adresse bevor wir den Post veröffentlichen können."
      redirect_to root_url
    else
      flash[:error] = "Es ist ein Fehler aufgetreten, bitte versuche es erneut."
    end
  end

  def show
    @article = Article.find(params[:id])
    render 'articles/show'
  end

  def confirm_email
    article = Article.find_by_confirm_token(params[:id])
    if article
      article.email_activate
      flash[:success] = "Vielen Dank! Deine E-Mail Adresse wurde bestätigt. \nWir überprüfen deinen Post und veröffentlichen ihn dann."
      redirect_to root_url
    else
      flash[:error] = "Dieses Token ist nicht gültig."
      redirect_to root_url
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :tag, :email)
  end
end
