class Picture < ApplicationRecord
  mount_uploader :picture, AvatarUploader
end
