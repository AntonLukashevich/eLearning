require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list :user, 5 }
  let(:user) { create :user }
  let(:role) {create :role}


  context 'GET #index' do

    before do
      allow(User).to receive(:all).and_return(users)
      get :index # попадаем в action index
    end

    it 'render template #index' do
      is_expected.to render_template :index
    end

    it 'return users' do
      expect(assigns(:users)).to match_array(users)
    end
  end

  context 'POST #create' do
    let(:users_params) do
      {
        user: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email,
          password: '123123',
          role_id: role,
          password_confirmation: '_WVg1GAVZdypsXjKWVYT',
          avatar: Faker::Avatar.image
        }
      }

    end
    subject { post :create, params: users_params}


    it 'save user' do
      binding.pry
      expect { subject }.to change(User, :count).by 1
    end
  end

end