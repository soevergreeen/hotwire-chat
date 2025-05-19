require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let!(:room) { Room.create!(name: 'ExistingRoom') }
  let(:valid_attributes)   { { name: 'NewRoom' } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    it 'loads all rooms and renders the index template' do
      get :index
      expect(assigns(:rooms)).to include(room)
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'loads the requested room and renders the show template' do
      get :show, params: { id: room.id }
      expect(assigns(:room)).to eq(room)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'initializes a new room and renders the new template' do
      get :new
      expect(assigns(:room)).to be_a_new(Room)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'loads the room for editing and renders the edit template' do
      get :edit, params: { id: room.id }
      expect(assigns(:room)).to eq(room)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new room and redirects to show' do
        expect {
          post :create, params: { room: valid_attributes }
        }.to change(Room, :count).by(1)
        expect(response).to redirect_to(Room.last)
        expect(flash[:notice]).to eq("Room was successfully created.")
      end
    end

    context 'with invalid attributes' do
      it 'does not create a room and re-renders new' do
        expect {
          post :create, params: { room: invalid_attributes }
        }.not_to change(Room, :count)
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the room and redirects to show' do
        patch :update, params: { id: room.id, room: { name: 'UpdatedName' } }
        room.reload
        expect(room.name).to eq('UpdatedName')
        expect(response).to redirect_to(room)
        expect(flash[:notice]).to eq("Room was successfully updated.")
      end
    end

    context 'with invalid attributes' do
      it 'does not update the room and re-renders edit' do
        original_name = room.name
        patch :update, params: { id: room.id, room: invalid_attributes }
        room.reload
        expect(room.name).to eq(original_name)
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the room and redirects to index' do
      expect {
        delete :destroy, params: { id: room.id }
      }.to change(Room, :count).by(-1)
      expect(response).to redirect_to(rooms_path)
      expect(response).to have_http_status(:see_other)
      expect(flash[:notice]).to eq("Room was successfully destroyed.")
    end
  end
end
