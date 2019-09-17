class ArticlesController < ApplicationController

  def new
    render 'articles/new'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      email_confirmation(@article)
      redirect_to "#{root_url}?please_confirm_email=true"
    else
      flash[:error] = "Es ist ein Fehler aufgetreten, bitte versuche es erneut."
    end
  end

  def show
    article = Article.find(params[:id])
    if article && article.confirmed && article.published
      @article = article
      render 'articles/show'
    else
      not_found
    end
  end

  def confirm_email
    article = Article.find_by_confirm_token(params[:id])
    if article
      if article.email_activate!
        post_publish(article)
        redirect_to "#{root_url}?mail_confirmed=true"
      end
    else
      redirect_to "#{root_url}?unknown_token=true"
    end
  end

  def publish_post
    article = Article.find_by_publish_token(params[:id])
    if article
      article.publish!
      post_published_notice(article)
      redirect_to article
    else
      redirect_to "#{root_url}?unknown_token=true"
    end
  end

  private

  def email_confirmation(article)
    api_key = ENV['mailgun_api_key']
    domain = ENV['mailgun_email_domain']

    @article = article
    html_output = render_to_string template: 'user_mailer/email_confirmation.text'

    response = RestClient.post "https://api:#{api_key}"\
        "@api.eu.mailgun.net/v3/#{domain}/messages",
                               :from => "Kondolenzbuch Pascal <info@#{domain}>",
                               :to => "<#{article.email}>",
                               :subject => 'Email Bestätigung',
                               :text => html_output.to_str

    JSON.parse(response)
  end

  def post_publish(article)
    api_key = ENV['mailgun_api_key']
    domain = ENV['mailgun_email_domain']
    confirmation_email = ENV['post_publish_email']

    @article = article
    html_output = render_to_string template: 'user_mailer/email_publication.text'

    response = RestClient.post "https://api:#{api_key}"\
        "@api.mailgun.net/v3/#{domain}/messages",
                               :from => "Kondolenzbuch Pascal <info@#{domain}>",
                               :to => "<#{confirmation_email}>",
                               :subject => 'Post Bestätigung',
                               :text => html_output.to_str

    JSON.parse(response)
  end

  def post_published_notice(article)
    api_key = ENV['mailgun_api_key']
    domain = ENV['mailgun_email_domain']

    @article = article
    html_output = render_to_string template: 'user_mailer/post_published.text'

    response = RestClient.post "https://api:#{api_key}"\
        "@api.mailgun.net/v3/#{domain}/messages",
                               :from => "Kondolenzbuch Pascal <info@#{domain}>",
                               :to => "<#{article.email}>",
                               :subject => 'Post Veröffentlicht',
                               :text => html_output.to_str

    JSON.parse(response)
  end

  def article_params
    params.require(:article).permit(:title, :text, :tag, :email)
  end
end
