class OrgCourse < ApplicationRecord
  belongs_to :organization
  belongs_to :course
end
