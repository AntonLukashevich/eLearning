# frozen_string_literal: true

class OrgCourse < ApplicationRecord
  belongs_to :organization
  belongs_to :course
end
