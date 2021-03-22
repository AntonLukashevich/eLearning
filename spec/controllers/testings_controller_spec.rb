RSpec.describe TestingsController, type: :controller do
  let(:course) {create :course}
  let(:testings) {create_list :testing, 5}
  let(:testing) {create :testing}

  let(:testing_params) do
    {
      testing: {
        title: "Faker::Name.name",
        description: "Faker::Name.name",
        course_id: course
      }
    }
  end

  let(:testing_params_invalid) do
    {
      testing: {
        description: Faker::Name.name,
        course_id: course
      }
    }
  end




  describe 'GET #index' do
    context 'index action' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        get :index, params: { course_id: course }
      end

      it 'render template #index' do
        is_expected.to render_template :index
      end

      it 'return testings' do
        expect(assigns(:testings)).to match_array(testings)
      end
    end
  end

  describe 'GET #show' do
    context 'action show' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        get :show, params: { course_id: course, id: testing.id }
      end

      it 'render show template if testing found' do
        expect(response).to render_template('show')
      end

      it 'return testing' do
        expect(assigns(:testing)).to eq(testing)
      end

    end
  end

  describe 'GET #new' do
    context 'action new' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(Testing).to receive(:new).and_return(testing)
        get :new, params: { course_id: course }
      end

      it 'create a new testing' do
        expect(assigns(:testing)).to be(testing)
      end
    end
  end

  describe 'GET #edit' do
    context 'action edit' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)

      end

      it 'finds a specific testing' do
        course.testings.should_receive(:find).once.and_return(testing)
        get :edit, params: { course_id: course, id: testing.id }
      end

      it 'renders the edit view' do
        get :edit, params: { course_id: course, id: testing.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context 'when params valid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(Testing).to receive(:new).and_return(testing)
        post :create, params: { course_id: course, testing: testing_params }
      end

      it 'create a new testing' do
        expect(assigns(:testing)).to be(testing)
      end

      it "redirects to the correct url: course_path(course)" do
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        post :create, params: { course_id: course, testing: testing_params_invalid }
      end

      it 'create a new lecture' do
        expect(assigns(:testing)).to_not be(testing)
      end

      it 'render template #new' do
        is_expected.to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow(Course).to receive(:find).and_return(course)
      allow(course).to receive(:testings).and_return(testings)
      allow(course.testings).to receive(:find).and_return(testing)
    end

    context 'when params valid' do
      it 'redirect to correct url after update' do
        patch :update, params: { course_id: course, id: testing, lecture: testing_params }
        #lecture.reload
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when params invalid' do
      before do
        patch :update, params: { course_id: course, id: testing.id, lecture: testing_params_invalid }
      end

      it 'render template #edit' do
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'action destroy' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
      end

      it 'delete testing' do
        expect do
          delete :destroy, params: { id: testing.id, course_id: course.id }
        end.to change(Testing, :count).by(-1)
      end

      it 'redirect to course when course destroyed' do
        delete :destroy, params: { course_id: course.id, id: testing.id }
        expect(subject).to redirect_to(course_path(course))
      end
    end
  end

end