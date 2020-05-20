require 'rails_helper'

RSpec.describe ScrapeResultsController, type: :controller do
  let!(:scrape_result) { create :scrape_result }

  describe 'GET show' do
    context 'with record in database' do
      before { get :show, params: { id: scrape_result.id } }

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'assigns @scrape_result' do
        expect(assigns(:scrape_result)).to eq(scrape_result)
      end
    end

    context 'without record in database' do
      it 'redirects to root_path with error message' do
        get :show, params: { id: 100 }

        expect(response).to redirect_to(root_path)
        expect(flash[:info]).to eq('Invalid Scrape Result')
      end
    end
  end

  describe 'GET edit' do
    before { get :edit, params: { id: scrape_result.id } }

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns @scrape_result' do
      expect(assigns(:scrape_result)).to eq(scrape_result)
    end
  end

  describe 'PATCH update' do
    context 'with valid scrape_result attributes' do
      let(:scrape_result_attributes) { { result_value: '500' } }

      it 'changes scrape_result result_value' do
        expect {
          patch :update, params: { id: scrape_result.id, scrape_result: scrape_result_attributes }
        }.to change { scrape_result.reload.result_value }
      end

      it 'redirects to scrape_result_path with flash message' do
        patch :update, params: { id: scrape_result.id, scrape_result: scrape_result_attributes }
        flash_message = "Scrape result '#{scrape_result.name}' updated successfully!"

        expect(response).to redirect_to(scrape_result_path(scrape_result))
        expect(flash[:success]).to eq(flash_message)
      end

      it 'marks scrape_result as changed manually' do
        patch :update, params: { id: scrape_result.id, scrape_result: scrape_result_attributes }

        expect(scrape_result.reload.manual_change).to be_truthy
      end
    end

    context 'with invalid scraper attributes' do
      let(:scrape_result_attributes) { { ruleset_id: nil } }

      it 'renders edit template with error message' do
        patch :update, params: { id: scrape_result.id, scrape_result: scrape_result_attributes }
        error_message = 'Ruleset must exist'

        expect(response).to render_template(:edit)
        expect(flash[:danger]).to eq(error_message)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes scrape_result successfully' do
      expect {
        delete :destroy, params: { id: scrape_result.id }
      }.to change { ScrapeResult.count }.from(1).to(0)
    end

    it 'redirects to root_path with flash message' do
      delete :destroy, params: { id: scrape_result.id }
      flash_message = 'Scrape Result deleted successfully'

      expect(response).to redirect_to(scraper_ruleset_path(scrape_result.ruleset.scraper, scrape_result.ruleset))
      expect(flash[:success]).to eq(flash_message)
    end
  end
end
