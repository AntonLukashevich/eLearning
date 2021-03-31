# frozen_string_literal: true

require 'rails_helper'
RSpec.describe QuestionsController, type: :controller do
  let(:course) { create :course }
  let(:testing) { create :testing }
  let(:testings) { create_list :testing, 5 }
  let(:question) { create :question }
  let(:questions) { create_list :question, 5 }

  let(:answer_params) do
    {
      answer: {
        answer: 'Test answer',
        isCorrect: true,
        position: rand(1..5),
        question: question
      }
    }
  end

  let(:question_params) do
    {
      question: {
        question: 'Question Test',
        type_question: 'radio',
        answers_attributes: answer_params
      }
    }
  end

  let(:question_params_invalid) do
    {
      question: {
        type_question: 'radio',
        answers_attributes: answer_params
      }
    }
  end

  describe 'GET #index' do
    context 'index action' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
        get :index, params: { course_id: course, testing_id: testing }
      end

      it 'render template #index' do
        is_expected.to render_template :index
      end

      it 'return questions' do
        expect(assigns(:questions)).to match_array(questions)
      end
    end
  end

  describe 'GET #show' do
    context 'action show' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
        get :show, params: { course_id: course, testing_id: testing, id: question }
      end

      it 'render show template if testing found' do
        expect(response).to render_template('show')
      end

      it 'return testing' do
        expect(assigns(:question)).to eq(question)
      end
    end
  end

  describe 'GET #new' do
    context 'action new' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(Question).to receive(:new).and_return(question)
        get :new, params: { course_id: course, testing_id: testing }
      end

      it 'create a new testing' do
        expect(assigns(:question)).to be(question)
      end
    end
  end

  describe 'GET #edit' do
    context 'action edit' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
      end

      it 'finds a specific question' do
        testing.questions.should_receive(:find).once.and_return(question)
        get :edit, params: { course_id: course, testing_id: testing.id, id: question }
      end

      it 'renders the edit view' do
        get :edit, params: { course_id: course, testing_id: testing.id, id: question }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context 'when params valid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(Question).to receive(:new).and_return(question)
        post :create, params: { course_id: course, testing_id: testing, question: question_params }
      end

      it 'create a new question' do
        expect(assigns(:question)).to be(question)
      end

      it 'redirects to the correct url: course_path(course)' do
        expect(response).to redirect_to(course_testing_path(course, testing))
      end
    end

    context 'when params invalid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        post :create, params: { course_id: course, testing_id: testing, question: question_params_invalid }
      end

      it 'create a new question' do
        expect(assigns(:question)).to_not be(question)
      end

      it 'render template #new' do
        is_expected.to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'when params valid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
        patch :update, params: { course_id: course, testing_id: testing, id: question, question: question_params }
      end

      it 'redirect to correct url after update' do
        expect(response).to redirect_to(course_testing_path(course, testing))
      end
    end

    context 'when params invalid' do
      before do
        allow(Course).to receive(:find).and_return(course)
        allow(course).to receive(:testings).and_return(testings)
        allow(course.testings).to receive(:find).and_return(testing)
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
        patch :update,
              params: { course_id: course, testing_id: testing, id: question, question: question_params_invalid }
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
        allow(testing).to receive(:questions).and_return(questions)
        allow(testing.questions).to receive(:find).and_return(question)
      end

      it 'delete question' do
        expect do
          delete :destroy, params: { testing_id: testing.id, course_id: course.id, id: question.id }
        end.to change(Question, :count).by(-1)
      end

      it 'redirect to course when course destroyed' do
        delete :destroy, params: { course_id: course.id, testing_id: testing.id, id: question }
        expect(subject).to redirect_to(course_testing_path(course, testing))
      end
    end
  end
end
