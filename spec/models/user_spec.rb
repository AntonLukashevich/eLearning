require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'relationship' do
    it 'belongs_to role' do
      should belong_to :role
    end

    # it "has_and_belongs_to_many courses" do
    #   should have_and_belongs_to_many :courses
    # end
    #
    # it 'has many certificates ' do
    #   should have_many :certificates
    # end

  end
end