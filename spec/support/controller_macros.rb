module ControllerMacros
  def login_user
    # Before each test, create and login the user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      role = FactoryBot.create(:role)
      course = FactoryBot.create(:course)
      testing = FactoryBot.create(:testing, course: course)
      question = FactoryBot.create(:question, testing: testing)
      user = FactoryBot.create(:user, role: role)
      # user.confirm! # Or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end

  def set_course

  end

  # Not used in this tutorial, but left to show an example of different user types
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryBot.create(:admin) # Using factory bot as an example
  #   end
  # end
end