require 'rails_helper'

RSpec.describe RulesetsController, type: :controller do
  describe 'GET new' do
    context 'with valid scraper' do
      let(:scraper) { create :scraper }
      before { get :new, params: { scraper_id: scraper.id } }

      it 'renders new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns @scraper' do
        expect(assigns(:scraper)).to eq(scraper)
      end

      it 'assigns @ruleset' do
        expect(assigns(:ruleset)).to be_a_new(Ruleset)
      end
    end

    context 'with invalid scraper' do
      # this will firstly redirect to scraper show page and to root page then
      it 'redirects to root_path with error message' do
        get :new, params: { scraper_id: 0 }

        expect(response).to redirect_to(scraper_path(0))
      end
    end
  end

  describe 'POST create' do
    let(:scraper) { create :scraper }

    context 'with valid ruleset attributes' do
      let(:ruleset_attributes) { attributes_for :ruleset }

      it 'creates ruleset successfully' do
        expect {
          post :create, params: { scraper_id: scraper.id, ruleset: ruleset_attributes }
        }.to change { Ruleset.count }.from(0).to(1)
      end

      it 'redirects to scraper_ruleset_path with flash message' do
        post :create, params: { scraper_id: scraper.id, ruleset: ruleset_attributes }
        msg = "Ruleset #{ruleset_attributes[:name]} created successfully!"

        expect(response).to redirect_to(scraper_ruleset_path(scraper, Ruleset.last))
        expect(flash[:success]).to eq(msg)
      end
    end

    context 'with invalid ruleset attributes' do
      let(:ruleset_attributes) { attributes_for :ruleset, url: '', parent_rule: '' }

      it "doesn't create ruleset" do
        expect {
          post :create, params: { scraper_id: scraper.id, ruleset: ruleset_attributes }
        }.not_to  change { Ruleset.count }
      end

      it 'renders new template with error message' do
        post :create, params: { scraper_id: scraper.id, ruleset: ruleset_attributes }
        msg = "Url can't be blank and Parent rule can't be blank"

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(msg)
      end
    end
  end

  describe 'GET show' do
    let(:scraper) { create :scraper }

    context 'with record in database' do
      let(:ruleset) { create :ruleset }

      it 'renders show template' do
        get :show, params: { id: ruleset.id, scraper_id: scraper.id }

        expect(response).to render_template(:show)
      end

      it 'assigns @ruleset' do
        get :show, params: { id: ruleset.id, scraper_id: scraper.id }

        expect(assigns(:ruleset)).to eq(ruleset)
      end
    end

    context 'without record in database' do
      it 'redirects to scraper_path with error message' do
        get :show, params: { id: 100, scraper_id: scraper.id }

        expect(response).to redirect_to(scraper_path(scraper))
        expect(flash[:info]).to eq('Invalid ID')
      end
    end
  end

  describe 'GET edit' do
    let(:scraper) { create :scraper }

    context 'with record in database' do
      let(:ruleset) { create :ruleset, scraper: scraper }

      before { get :edit, params: { scraper_id: scraper.id, id: ruleset.id } }

      it 'renders new template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns @scraper' do
        expect(assigns(:scraper)).to eq(scraper)
      end

      it 'assigns @ruleset' do
        expect(assigns(:ruleset)).to eq(ruleset)
      end
    end

    context 'without record in database' do
      it 'redirects to scraper_path with error message' do
        get :edit, params: { id: 100, scraper_id: scraper.id }

        expect(response).to redirect_to(scraper_path(scraper))
        expect(flash[:info]).to eq('Invalid ID')
      end
    end
  end

  describe 'PATCH update' do
    let(:scraper) { create :scraper }

    context 'with record in database' do
      let(:ruleset) { create :ruleset, scraper: scraper }

      context 'with valid ruleset attributes' do
        let(:ruleset_attributes) { { url: 'www.example2.com' } }

        it 'changes ruleset url' do
          expect {
            patch :update, params: { ruleset: ruleset_attributes, id: ruleset.id, scraper_id: scraper.id }
          }.to change { ruleset.reload.url }
        end

        it 'redirects to scraper_ruleset_path with flash message' do
          patch :update, params: { ruleset: ruleset_attributes, id: ruleset.id, scraper_id: scraper.id }
          flash_message = "Ruleset #{ruleset.name} updated successfully!"

          expect(response).to redirect_to(scraper_ruleset_path(scraper, ruleset))
          expect(flash[:success]).to eq(flash_message)
        end
      end

      context 'with invalid scraper attributes' do
        let(:ruleset_attributes) { { url: nil } }

        it 'renders edit template with error message' do
          patch :update, params: { ruleset: ruleset_attributes, id: ruleset.id, scraper_id: scraper.id }
          error_message = "Url can't be blank"

          expect(response).to render_template(:edit)
          expect(flash[:danger]).to eq(error_message)
        end
      end
    end

    context 'without record in database' do
      it 'redirects to scraper_path with error message' do
        patch :update, params: { id: 100, scraper_id: scraper.id }

        expect(response).to redirect_to(scraper_path(scraper))
        expect(flash[:info]).to eq('Invalid ID')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with record in database' do
      let!(:ruleset) { create :ruleset }

      it 'deletes ruleset successfully' do
        expect {
          delete :destroy, params: { id: ruleset.id, scraper_id: ruleset.scraper.id }
        }.to change { Ruleset.count }.from(1).to(0)
      end

      it 'redirects to root_path with flash message' do
        scraper_id = ruleset.scraper.id
        delete :destroy, params: { id: ruleset.id, scraper_id: scraper_id }
        flash_message = 'Ruleset deleted successfully'

        expect(response).to redirect_to(scraper_path(scraper_id))
        expect(flash[:success]).to eq(flash_message)
      end
    end

    context 'without record in database' do
      let(:scraper) { create :scraper }
      it 'redirects to scraper_path with error message' do
        delete :destroy, params: { id: 100, scraper_id: scraper.id }

        expect(response).to redirect_to(scraper_path(scraper))
        expect(flash[:info]).to eq('Invalid ID')
      end
    end
  end
end
