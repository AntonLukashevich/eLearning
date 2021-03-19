require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list :user, 5 }
  let(:user) { create :user }
  let(:role) {create :role}

  let(:user_params) do
    {
      user: {
        id: 777,
        first_name: "Igor",
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

  context 'GET #new' do
    before do
      allow(User).to receive(:new).and_return(user)
      get :new
    end

    it 'creates a new user ' do
      expect(assigns(:user)).to be(user)
    end

  end

  context 'GET #edit' do

    it 'finds a specific user' do
      User.should_receive(:find).once.and_return(user)
      get :edit, params: { id: user.id }
    end

    it 'renders the edit view' do
      get :edit, params: { id: user.id }
      expect(response).to render_template('edit')
    end
  end

  context 'POST #create' do
    context 'when valid params' do
      before do
        allow(User).to receive(:new).and_return(user)
        allow(user).to receive(:save).and_return(true)
        # we need to stub the #new and the #save methods on the
        # class and double
      end

      it "creates a new user" do
        post :create,  params:  user_params
        #expect the instance of @user to be a user.
        expect(assigns(:user)).to be(user)
      end

      it "redirects to the correct url: user_path(user)" do
        post :create, params:  user_params
        expect(response).to redirect_to(user_path(user))
      end

    end

    context 'when invalid params' do
      it 'not creates a new user' do
        post :create,  params:  user_params_invalid
        expect(assigns(:user)).to_not be(user)
      end

      it 'render template #new' do
        post :create,  params:  user_params_invalid
        is_expected.to render_template :new
      end
    end
  end

  context 'PATCH #update' do
    context "when valid params" do
      subject {post :update, params: user_params}
      it 'change name' do
        user.update(:first_name => "Igor")
        #user.reload
        expect(user.first_name).to eq("Igor")

      end

      let(:params)  { {user_id: user.id }}
      it 'redirect to user after update' do
        patch :update , params: {id: user, user: user_params}
        user.reload
        expect(response).to be_redirect
      end
    end

    context 'when invalid params' do
      it 'render template #edit' do
        get :edit , params: {id: user, user: user_params_invalid }
        expect(response).to render_template('edit')
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

end