require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'relationship' do
    it 'belongs_to role' do
      should belong_to :role
    end

  end
end