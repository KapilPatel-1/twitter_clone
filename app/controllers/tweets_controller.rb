class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all.order("created_at DESC")
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      respond_to do |format|
        format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      end
    else
      render :new
    end
  end

  def show
    
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: 'Tweet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: 'Tweet was successfully destroyed.'
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content, :media)
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def authorize_user!
      redirect_to tweets_path, alert: "Not authorized!" if @tweet.user != current_user
    end
end
