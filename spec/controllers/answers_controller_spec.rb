require 'spec_helper.rb'
require "rails_helper"

RSpec.describe 'AnswersController' do
  describe 'show' do
    let(:klass) { described_class }
    let(:local_answer) { Answer.new(answer: 'Foo', isCorrect: true) } # можно обращаться в базу
    let(:local_answer_two) { build_stubbed(:answer) } # build_stubbed не имеет доступа к базе

    before do
      allow(Answer).to receive(:find).and_return(5)
      klass.instance_variable_set(:@answer, 5)
    end

    context 'when params are valid' do
      it 'returns non nil value' do
        expect(Answer).to receive(:find).and_return(5)
        expect(klass.instance_variable_get(:@answer)).to eq(5)
      end
    end
  end
end

#TODO: add factory_bot