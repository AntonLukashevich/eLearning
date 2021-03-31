# frozen_string_literal: true

class PicturesController < ApplicationController # rubocop:todo Style/Documentation
  def create
    @picture = Picture.new(picture_params)
    @picture.save
    respond_to do |format|
      format.json { render json: { url: @picture.picture.url(:big), picture_id: @picture.id } }
    end
  end

  def destroy
    picture = Picture.find(params[:id])
    picture.destroy
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:picture)
  end
end
