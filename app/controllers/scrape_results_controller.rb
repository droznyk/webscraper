class ScrapeResultsController < ApplicationController
  before_action :fetch_scrape_result
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_scrape_result

  def show; end

  def edit; end

  def update
    if @scrape_result.update(scrape_result_params.merge(manual_change: true))
      flash[:success] = "Scrape result '#{@scrape_result.name}' updated successfully!"
      redirect_to scrape_result_path(@scrape_result)
    else
      flash.now[:danger] = @scrape_result.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @scrape_result.destroy
    flash[:success] = 'Scrape Result deleted successfully'
    redirect_to scraper_ruleset_path(@scrape_result.ruleset.scraper, @scrape_result.ruleset)
  end

  private

  def fetch_scrape_result
    @scrape_result = ScrapeResult.includes(ruleset: :scraper).find(params[:id])
  end

  def scrape_result_params
    params.require(:scrape_result).permit(:ruleset_id, :result_value)
  end

  def invalid_scrape_result
    redirect_to root_path, info: 'Invalid Scrape Result'
  end
end
