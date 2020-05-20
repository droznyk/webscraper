class RulesetsController < ApplicationController
  before_action :fetch_scraper
  before_action :fetch_ruleset, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_ruleset

  def new
    @ruleset = @scraper.rulesets.build
  end

  def create
    @ruleset = @scraper.rulesets.build(ruleset_params)
    if @ruleset.save
      flash[:success] = "Ruleset #{@ruleset.name} created successfully!"
      redirect_to scraper_ruleset_path(@scraper, @ruleset)
    else
      flash.now[:danger] = @ruleset.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @ruleset = Ruleset.includes(:scrape_results).find(params[:id])
  end

  def edit; end

  def update
    if @ruleset.update(ruleset_params)
      flash[:success] = "Ruleset #{@ruleset.name} updated successfully!"
      redirect_to scraper_ruleset_path(@scraper, @ruleset)
    else
      flash.now[:danger] = @ruleset.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @ruleset.destroy
    flash[:success] = 'Ruleset deleted successfully'
    redirect_to scraper_path(params[:scraper_id])
  end

  def scrape
    ruleset = Ruleset.find(params[:ruleset_id])
    result = HandleSingleItemScrapingService.new(ruleset).call
    flash[result.keys.first] = result.values.first
    redirect_to scraper_ruleset_path(ruleset.scraper, ruleset)
  end

  private

  def fetch_scraper
    @scraper = Scraper.find(params[:scraper_id])
  end

  def fetch_ruleset
    @ruleset = @scraper.rulesets.find(params[:id])
  end

  def invalid_ruleset
    redirect_to scraper_path(params[:scraper_id]), info: 'Invalid ID'
  end

  def ruleset_params
    params.require(:ruleset).permit(:name, :description, :url, :parent_rule, :child_rule,
      :parent_rule_is_xpath, :child_rule_is_xpath)
  end
end
