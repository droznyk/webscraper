class ScrapersController < ApplicationController
  before_action :fetch_scraper, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_scraper

  def index
    @scrapers = Scraper.by_id
  end

  def new
    @scraper = Scraper.new
  end

  def create
    @scraper = Scraper.new(scraper_params)
    if @scraper.save
      flash[:success] = "Scraper #{@scraper.name} created successfully!"
      redirect_to scrapers_path
    else
      flash.now[:danger] = @scraper.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @scraper = Scraper.preload(rulesets: :scrape_results).find(params[:id])
  end

  def edit; end

  def update
    if @scraper.update(scraper_params)
      flash[:success] = "Scraper #{@scraper.name} updated successfully!"
      redirect_to scrapers_path
    else
      flash.now[:danger] = @scraper.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @scraper.destroy
    flash[:success] = 'Scraper deleted successfully'
    redirect_to root_path
  end

  private

  def scraper_params
    params.require(:scraper).permit(:name, :description)
  end

  def fetch_scraper
    @scraper = Scraper.find(params[:id])
  end

  def invalid_scraper
    redirect_to scrapers_path, info: 'Invalid Scraper'
  end
end
