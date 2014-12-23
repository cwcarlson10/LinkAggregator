class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :up_vote, :down_vote]

  def index
    @links = Link.all.order(votes: :desc)
  end

  def show
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    if @link.save
      redirect_to links_path(@links)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @link.update_attributes(link_params)
      redirect_to @links
    else
      render :edit
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path
  end

  def up_vote
    @link = Link.find(params[:id])
    @link.votes += 1
    @link.save
    redirect_to root_path
  end

  def down_vote
    @link = Link.find(params[:id])
    @link.votes -= 1
    @link.save
    redirect_to root_path
  end

  private
    def link_params
      params.require(:link).permit(:title, :url, :votes)
    end

    def set_link
      @link = Link.find(params[:id])
    end
end
