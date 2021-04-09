# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { create :user }
  let(:role) { create :role }
  let(:courses) { create_list :course, 5 , status: 'ready'}
  let(:course) { create :course }

  let(:course_params) do
    {
      course: {
        title: Faker::Name.name,
        description: Faker::Name.name,
        type_course: 'public',
        rating: rand(1..100),
        status: 'draft',
        # user_id: user,
        image: Faker::Avatar.image
      }
    }
  end

  let(:course_params_invalid) do
    {
      course: {
        title: 'T',
        description: Faker::Name.name,
        type_course: 'public',
        rating: rand(1..100),
        status: 'draft',
        # user_id: user,
        image: Faker::Avatar.image
      }
    }
  end

  describe 'GET #index' do
    context 'index action' do
      let(:course_relation) { instance_double('ActiveRecord::Relation') }
      before do
        allow(Course).to receive(:where).with(status: 'ready').and_return(course_relation)
        allow(course_relation).to receive(:includes).with(:users).and_return(courses)
        get :index # попадаем в action index
      end

      it 'render template #index' do
        is_expected.to render_template :index
      end

      it 'return courses' do
        expect(assigns(:courses)).to match_array(courses)
      end
    end
  end

  describe 'GET #show' do
    context 'show action' do
      let(:readeds_relation) { instance_double('ActiveRecord::Relation') }
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(Readed).to receive(:where).with(user_id: user.id).and_return(readeds_relation)
      end

      it 'render show template if course found' do
        get :show, params: { id: course.id }
        expect(response).to render_template('show')
      end

      it 'return course' do
        get :show, params: { id: course.id }
        expect(assigns(:course)).to eq(course)
      end
    end
  end

  describe 'GET #new' do
    context 'action new' do
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
      get :edit, params: { id: course.id }
      Course.should_receive(:find).once.and_return(course)
    end

    it 'renders the edit view' do
      get :edit, params: { id: course.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #create' do
    context 'when params valid' do
      before do
        allow(User).to receive(:find).and_return(user)
        allow(user.courses).to receive(:create).and_return(course)
        post :create, params: { user_id: user, course: course_params }
      end

      it 'create a new course' do
        expect(assigns(:course)).to be(course)
      end

      it 'redirects to the correct url: course_path(course)' do
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        post :create, params: { user_id: user, course: course_params_invalid }
      end

      it 'not creates a new course' do
        expect(assigns(:course)).to_not be(course)
      end

      it 'render template #new' do
        is_expected.to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'when params valid' do
      let(:params) { { course_id: course.id } }
      it 'redirect to user after update' do
        patch :update, params: { id: course, course: course_params }
        course.reload
        expect(response).to be_redirect
      end
    end

    context 'when params invalid' do
      it 'render template #edit' do
        get :edit, params: { id: course, course: course_params_invalid }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }
    let(:params) { { id: course.id, user_id: user.id } }

    it 'delete course' do
      course.reload
      expect { subject }.to change(Course, :count).by(-1)
    end

    it 'redirect to #index when course destroyed' do
      expect(subject).to redirect_to(courses_path)
    end
  end
end
