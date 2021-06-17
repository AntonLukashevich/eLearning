# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LecturesController, type: :controller do
  let(:course) { create :course }
  let(:lectures) { create_list :lecture, 5 }
  let(:lecture) { create :lecture }
  let(:current_user) { create :user }
  let(:readed) { create :readed, user_id: current_user.id }

  let(:lecture_params) do
    {
      lecture: {
        title: Faker::Name.name,
        description: Faker::Name.name,
        content: 'content',
        position: rand(1..5)

      }
    }
  end

  let(:lecture_params_invalid) do
    {
      lecture: {
        description: Faker::Name.name,
        content: 'content'

      }
    }
  end

  describe 'GET #index' do
    context 'index action' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:lectures).and_return(lectures)
        get :index # попадаем в action index
      end

      it 'render template #index' do
        is_expected.to render_template :index
      end

      it 'return lectures' do
        expect(assigns(:lectures)).to match_array(lectures)
      end
    end
  end

  describe 'GET #show' do
    context 'action show' do
      let(:readeds_relation) { instance_double('ActiveRecord::Relation') }

      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:lectures).and_return(lectures)
        allow(course.lectures).to receive(:find).and_return(lecture)

        allow(Readed).to receive(:where).with(lecture_id: lecture, user_id: current_user).and_return(readeds_relation)
        allow(readeds_relation).to receive(:first).and_return(readed)
      end

      it 'render show template if lecture found' do
        get :show, params: { course_id: course, id: lecture.id }
        expect(response).to render_template('show')
      end

      it 'return lecture' do
        get :show, params: { course_id: course, id: lecture.id }
        expect(assigns(:lecture)).to eq(lecture)
      end
    end
  end

  describe 'GET #new' do
    context 'action new' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(Lecture).to receive(:new).and_return(lecture)
        get :new, params: { course_id: course }
      end

      it 'create a new lecture' do
        expect(assigns(:lecture)).to be(lecture)
      end
    end
  end

  describe 'GET #edit' do
    context 'action edit' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:lectures).and_return(lectures)
        allow(course.lectures).to receive(:find).and_return(lecture)
      end

      it 'finds a specific lecture' do
        course.lectures.should_receive(:find).once.and_return(lecture)
        get :edit, params: { course_id: course, id: lecture.id }
      end

      it 'renders the edit view' do
        get :edit, params: { course_id: course, id: lecture.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context 'when params valid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(Lecture).to receive(:new).and_return(lecture)
        post :create, params: { course_id: course, lecture: lecture_params }
      end

      it 'create a new lecture' do
        expect(assigns(:lecture)).to be(lecture)
      end

      it 'redirects to the correct url: course_path(course)' do
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        post :create, params: { course_id: course, lecture: lecture_params_invalid }
      end

      it 'create a new lecture' do
        expect(assigns(:lecture)).to_not be(lecture)
      end

      it 'render template #new' do
        is_expected.to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow(Course).to receive(:find).and_return(course)
      allow(course).to receive(:lectures).and_return(lectures)
      allow(course.lectures).to receive(:find).and_return(lecture)
    end

    context 'when params valid' do
      it 'redirect to correct url after update' do
        patch :update, params: { course_id: course, id: lecture, lecture: lecture_params }
        # lecture.reload
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:lectures).and_return(lectures)
        allow(course.lectures).to receive(:find).and_return(lecture)
        patch :update, params: { course_id: course, id: lecture.id, lecture: lecture_params_invalid }
      end

      it 'render template #edit' do
        is_expected.to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'action destroy' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:lectures).and_return(lectures)
        allow(course.lectures).to receive(:find).and_return(lecture)
      end

      it 'delete lecture' do
        expect do
          delete :destroy, params: { id: lecture.id, course_id: course.id }
        end.to change(Lecture, :count).by(-1)
      end

      it 'redirect to course when course destroyed' do
        delete :destroy, params: { course_id: course.id, id: lecture.id }
        expect(subject).to redirect_to(course_path(course))
      end
    end
  end
end
