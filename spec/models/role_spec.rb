require 'rails_helper'
RSpec.describe Role, type: :model do
  describe 'validation' do
    it 'validates name' do
      should validate_presence_of :name
    end

    it 'validates name length >= 3' do
      should validate_length_of :name
      expect(FactoryBot.build(:role, name: "us").valid?).to eq(false)
      expect(FactoryBot.build(:role, name: "use").valid?).to eq(true)
    end
  end

  describe 'relationship' do
    it 'has_many users' do
      should have_many :users
    end
  end


end