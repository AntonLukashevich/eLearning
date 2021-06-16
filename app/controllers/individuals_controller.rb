class IndividualsController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @individuals = Individual.includes(:user).where(course_id: @course.id)
    @users = User.where(role: 'user')
  end

  def show
    binding.pry
    @individual = Individual.find(params[:id])
  end

  def new
    @course = Course.find(params[:course_id])
    @course_individuals = @course.individuals
    course_individual_ids = []

    @course_individuals.each do |individual|
      course_individual_ids << individual.user_id
    end

    @users = User.where.not(id: course_individual_ids).order(:email)
    @individual = Individual.new
  end

  def create
    @course = Course.find(params[:course_id])
    individ_user = params[:individual]
    binding.pry
    if Individual.where(course_id: @course.id, user_id: individ_user[:user_id].to_i).first.present?
      redirect_to course_individuals_path, info: 'The user has already been added'
    else
      @individual = @course.individuals.build(individual_params)
      respond_to do |format|
        if @individual.save
          format.js
          format.html{ redirect_to course_individuals_path, success: 'The user added to list!' }
        else
          format.html{ render 'new', danger: 'Error! Check input info...' }
        end
      end
    end


  end

  def destroy
    @course = Course.find(params[:course_id])
    @individual = Individual.find(params[:id])
    @individual.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to course_individuals_path(@course), info: 'The follower deleted!' }
      format.json
    end

  end

  private

  def individual_params
    params.require(:individual).permit(:user_id)
  end

end
