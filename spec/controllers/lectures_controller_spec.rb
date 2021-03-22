require "rails_helper"

RSpec.describe LecturesController, type: :controller do
  let(:course) { create :course }
  let(:lectures) { create_list :lecture, 5 }
  let(:lecture) { create_list :course, 5 }

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

      it 'return users' do
        expect(assigns(:lectures)).to match_array(lectures)
      end
    end
  end

  describe 'GET #show' do
    fcontext 'action show' do
      before do
         allow(Course).to receive(:find).and_return(course)
         allow(course).to receive(:lectures).and_return(lectures)
         allow(lectures).to receive(:lecture)
        get :show, params: {course_id: course, id: lecture}
      end

      it 'render show template if user found' do
        expect(response).to render_template('show')
      end

      it 'return lecture' do
        expect(assigns(:lecture)).to eq(lecture)
      end

    end
  end
end