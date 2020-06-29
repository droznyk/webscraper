require 'rails_helper'

RSpec.describe ScrapersController, type: :controller do
  describe 'GET index' do
    shared_examples 'index page is rendered' do
      it 'renders index template' do
        get :index

        expect(response).to render_template(:index)
      end
    end

    context 'with records in database' do
      let(:scrapers) { create_list :scraper, 5 }

      it 'assigns @scrapers' do
        get :index

        expect(assigns(:scrapers)).to eq(scrapers)
      end

      it_behaves_like 'index page is rendered'
    end

    context 'without records in database' do
      it '@scrapers are empty' do
        get :index

        expect(assigns(:scrapers)).to be_empty
      end

      it_behaves_like 'index page is rendered'
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns @scraper' do
      expect(assigns(:scraper)).to be_a_new(Scraper)
    end
  end

  describe 'POST create' do
    context 'with valid scraper attributes' do
      let(:scraper_attributes) { attributes_for :scraper }

      it 'creates scraper successfully' do
        expect { post :create, params: { scraper: scraper_attributes } }.to change { Scraper.count }.by(1)
      end

      it 'redirects to Scraper#index page with flash message' do
        post :create, params: { scraper: scraper_attributes }
        flash_message = "Scraper #{scraper_attributes[:name]} created successfully!"

        expect(response).to redirect_to(scrapers_path)
        expect(flash[:success]).to eq(flash_message)
      end
    end

    context 'with invalid scraper attributes' do
      let(:scraper_attributes) { attributes_for :scraper, name: nil }

      it "doesn't create scraper" do
        expect { post :create, params: { scraper: scraper_attributes } }.not_to change { Scraper.count }
      end

      it 'renders new template with error message' do
        post :create, params: { scraper: scraper_attributes }
        error_message = "Name can't be blank"

        expect(response).to render_template(:new)
        expect(flash[:danger]).to eq(error_message)
      end
    end
  end

  describe 'GET show' do
    context 'with record in database' do
      let(:scraper) { create :scraper }

      it 'renders show template' do
        get :show, params: { id: scraper.id }

        expect(response).to render_template(:show)
      end

      it 'assigns @scraper' do
        get :show, params: { id: scraper.id }

        expect(assigns(:scraper)).to eq(scraper)
      end
    end

    context 'without record in database' do
      it 'redirects to scrapers_path with error message' do
        get :show, params: { id: 100 }

        expect(response).to redirect_to(scrapers_path)
        expect(flash[:info]).to eq('Invalid Scraper')
      end
    end
  end

  describe 'GET edit' do
    context 'with record in database' do
      let(:scraper) { create :scraper }
      before { get :edit, params: { id: scraper.id } }

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns @scraper' do
        expect(assigns(:scraper)).to eq(scraper)
      end
    end

    context 'without record in database' do
      it 'redirects to scrapers_path with error message' do
        get :edit, params: { id: 100 }

        expect(response).to redirect_to(scrapers_path)
        expect(flash[:info]).to eq('Invalid Scraper')
      end
    end
  end

  describe 'PATCH update' do
    context 'with record in database' do
      let(:scraper) { create :scraper }

      context 'with valid scraper attributes' do
        let(:scraper_attributes) { attributes_for :scraper, name: 'Changed name' }

        it 'changes scraper name' do
          expect { patch :update, params: { scraper: scraper_attributes, id: scraper.id } }
            .to change { scraper.reload.name }
        end

        it 'redirects to scrapers_path with flash message' do
          patch :update, params: { scraper: scraper_attributes, id: scraper.id }
          flash_message = "Scraper #{scraper.reload.name} updated successfully!"

          expect(response).to redirect_to(scrapers_path)
          expect(flash[:success]).to eq(flash_message)
        end
      end

      context 'with invalid scraper attributes' do
        let(:scraper_attributes) { attributes_for :scraper, name: nil }

        it 'renders edit template with error message' do
          patch :update, params: { scraper: scraper_attributes, id: scraper.id }
          error_message = "Name can't be blank"

          expect(response).to render_template(:edit)
          expect(flash[:danger]).to eq(error_message)
        end
      end
    end

    context 'without record in database' do
      it 'redirects to scrapers_path with error message' do
        patch :update, params: { id: 100 }

        expect(response).to redirect_to(scrapers_path)
        expect(flash[:info]).to eq('Invalid Scraper')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with record in database' do
      let!(:scraper) { create :scraper }

      it 'deletes scraper successfully' do
        expect { delete :destroy, params: { id: scraper.id } }.to change { Scraper.count }.from(1).to(0)
      end

      it 'redirects to root_path with flash message' do
        delete :destroy, params: { id: scraper.id }
        flash_message = 'Scraper deleted successfully'

        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq(flash_message)
      end
    end

    context 'without record in database' do
      it 'redirects to scrapers_path with error message' do
        delete :destroy, params: { id: 100 }

        expect(response).to redirect_to(scrapers_path)
        expect(flash[:info]).to eq('Invalid Scraper')
      end
    end
  end
end
