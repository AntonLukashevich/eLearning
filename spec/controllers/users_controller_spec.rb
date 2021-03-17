require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list :user, 5 }
  let(:user) { create :user }
  let(:role) {create :role}
  let(:user_params) do
    {
      user: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123123',
        role_id: role,
        #password_confirmation: 'asdf',
        avatar: Faker::Avatar.image
      }
    }
  end

  let(:user_params_invalid) do
    {
      user: {
        first_name:  "A" ,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123123',
        role_id: role,
        #password_confirmation: '_WVg1GAVZdypsXjKWVYT',
        avatar: Faker::Avatar.image
      }
    }
  end


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
    context 'when valid params' do

      subject { post :create, params: user_params}
      #let(:params)  { { id: user.id }}

      it 'save user' do
        #binding.pry
        expect { subject } .to change(User, :count).by(1)
      end

       it 'redirect to user after save' do
         post :create , params: { user: user }
         #expect(response).to render_template('show')
         #expect(response).to redirect_to(user_path(user))
         #visit user_path(user)
         #expect(page.status_code).to eq(200)

         response.should redirect_to User.last
       end
    end

    context 'when invalid params' do
      subject { post :create, params: user_params_invalid}
      it 'not save user' do
        expect { subject } .to_not change(User, :count)
      end

      it 'render template #new' do
        is_expected.to render_template :new
      end
    end
  end

  context 'DELETE #destroy' do
    subject {delete :destroy, params: params}
    let(:params)  { { id: user.id }}

    it 'delete user' do
      user.reload
      expect { subject }.to change(User, :count).by(-1)
    end

    it 'redirect to #index when user destroyed' do
      expect(subject).to redirect_to(users_path)
    end
  end

  context "GET #show" do

    before do
      allow(User).to receive(:find).and_return(user)
      get :show, params: { id: user.id}
    end

    it 'render show template if user found' do
      expect(response).to render_template('show')
    end

    it 'return user' do
      expect(assigns(:user)).to eq(user)
    end

  end

end