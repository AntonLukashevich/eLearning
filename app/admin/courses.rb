ActiveAdmin.register Course do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :status, :type_course, :rating, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :status, :type_course, :rating, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    column :updated_at
    column :type_course
    column :rating
    column :lectures
    column :testings
    column :users
    actions
  end
end
