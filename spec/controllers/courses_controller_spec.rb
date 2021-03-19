require "rails_helper"

RSpec.describe CoursesController, type: :controller do
  let(:user) {create :user}
  let(:role) {create :role}
  let(:courses) { create_list :course, 5 }
  let(:course) { create :course }

  let(:course_params) do {
    course: {
      title: Faker::Name.name,
      description: Faker::Name.name,
      type_course: "public",
      rating: rand(1..100),
      status: "draft",
      #user_id: user,
      image: Faker::Avatar.image
    }
  }
  end

  let(:course_params_invalid) do {
    course: {
      title: "T",
      description: Faker::Name.name,
      type_course: "public",
      rating: rand(1..100),
      status: "draft",
      #user_id: user,
      image: Faker::Avatar.image
    }
  }
  end

  describe 'GET #index' do
    context 'index action' do
      before do
        allow(Course).to receive(:all).and_return(courses)
        get :index # попадаем в action index
      end

      it 'render template #index' do
        is_expected.to render_template :index
      end

      it 'return users' do
        expect(assigns(:courses)).to match_array(courses)
      end

    end
  end

  describe "GET #show" do
    context 'show action' do
      before do
        allow(Course).to receive(:find).and_return(course)
        get :show, params: { id: course.id}
      end

      it 'render show template if user found' do
        expect(response).to render_template('show')
      end

      it 'return user' do
        expect(assigns(:course)).to eq(course)
      end
    end
  end

  describe "GET #new" do
    context 'show action' do
      before do
        allow(Course).to receive(:new).and_return(course)
        get :new
      end

      it 'create a new course' do
        expect(assigns(:course)).to be(course)
      end
    end
  end

  describe 'GET #edit' do
    it 'finds a specific course' do
      Course.should_receive(:find).once.and_return(course)
      get :edit, params: {id: course.id}
    end

    it 'renders the edit view' do
      get :edit, params: {id: course.id}
      expect(response).to render_template('edit')
    end
  end

  describe "POST #create" do
    context 'when params valid' do
      before do
        allow(User).to receive(:find).and_return(user)
        allow(user).to receive(:courses).and_return(true)
        allow(Course).to receive(:new).and_return(course)
      end

      it 'create a new course' do
        post :create, params: course_params
        expect(assigns(:course)).to be(course)
      end

      it "redirects to the correct url: course_path(course)" do
        post :create, params:  course_params
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        allow(User).to receive(:find).and_return(user)
        allow(user).to receive(:courses)
        allow(Course).to receive(:new).and_return(course)
      end

      it 'not creates a new course' do
        post :create,  params:  course_params_invalid
        expect(assigns(:course)).to_not be(course)
      end

      it 'render template #new' do
        post :create,  params:  course_params_invalid
        is_expected.to render_template :new
      end

    end
  end

  describe 'PATCH #update' do
    context 'when valid params' do
      let(:params)  { {course_id: course.id }}
      it 'redirect to user after update' do
        patch :update , params: {id: course, course: course_params}
        course.reload
        expect(response).to be_redirect
      end
    end

    context 'when invalid params' do
      it 'render template #edit' do
        get :edit , params: {id: course, course: course_params_invalid }
        expect(response).to render_template('edit')
      end
    end
  end


  describe 'DELETE #destroy' do
    subject {delete :destroy, params: params}
    let(:params)  { { id: course.id, user_id: user.id }}

    it 'delete user' do
      course.reload
      expect { subject }.to change(Course, :count).by(-1)
    end

    it 'redirect to #index when course destroyed' do
      expect(subject).to redirect_to(courses_path)
    end
  end
end