# frozen_string_literal: true

class ArticlesController < ApplicationController
  EMAIL_CONFIRMATION_NEEDED = 'Dein Post wurde gespeichert.\n\nBitte bestätige deine E-Mail Adresse, damit wir ihn veröffentlichen können.'
  EMAIL_WAS_CONFIRMED = 'Deine E-Mail Adresse wurde bestätigt\n\nWir überprüfen deinen Post nun und veröffentlichen ihn dann.\n\nVielen Dank, dass du dir die Zeit genommen hast!'
  WRONG_TOKEN = 'Dieses Token ist ungültig!'

  def new
    @article = Article.new
    render 'articles/new'
  end

  def create
    @article = Article.new(article_params)
    return unless @article.save

    if email_confirmation(@article)
      flash[:popup] = EMAIL_CONFIRMATION_NEEDED
      redirect_to root_url
    else
      render 'error/invalid_email', status: :bad_request
    end
  end

  def list
    render 'articles/list'
  end

  def show
    @article = Article.find(params[:id])
    if @article&.confirmed && @article&.published
      render 'articles/show'
    else
      not_found
    end
  end

  def confirm_email
    @article = Article.find_by(confirm_token: params[:id])
    if @article
      if @article.email_activate!
        post_publish(@article)
        flash[:popup] = EMAIL_WAS_CONFIRMED
        redirect_to root_url
      end
    else
      flash[:popup] = WRONG_TOKEN
      redirect_to root_url
    end
  end

  def publish_post
    @article = Article.find_by(publish_token: params[:id])
    if @article
      @article.publish!
      post_published_notice(@article)
      redirect_to @article
    else
      flash[:popup] = WRONG_TOKEN
      redirect_to root_url
    end
  end

  private

  def email_confirmation(article)
    html_output = render_to_string template: 'user_mailer/email_confirmation.text'

    send_mail(article.email, 'Email Bestätigung', html_output)
  end

  def post_publish(_article)
    confirmation_email = ENV['post_publish_email']

    html_output = render_to_string template: 'user_mailer/email_publication.text'

    send_mail(confirmation_email, 'Post Freigabe', html_output)
  end

  def post_published_notice(article)
    html_output = render_to_string template: 'user_mailer/post_published.text'

    send_mail(article.email, 'Post Veröffentlicht', html_output)
  end

  def send_mail(to_email, subject, text)
    api_key = ENV['mailgun_api_key']
    domain = ENV['mailgun_email_domain']
    mailgun_api = ENV['mailgun_api']

    begin
      RestClient.post "https://api:#{api_key}"\
          "@#{mailgun_api}#{domain}/messages",
                      from: "Kondolenzbuch Pascal <info@#{domain}>",
                      to: "<#{to_email}>",
                      subject: subject,
                      text: text
    rescue RestClient::BadRequest
      return false
    end

    true
  end

  def article_params
    params.require(:article)
          .permit(:name, :text, :tag, :email).tap do |article_params|
      article_params.require(:name)
      article_params.require(:tag)
      article_params.require(:email)
    end
  end
end
