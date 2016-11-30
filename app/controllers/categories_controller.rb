class CategoriesController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index]
  include CategoriesHelper

  def new
    @category = Category.new(name: params[:name])
    if @category.valid? && @category.save
      add_to_categories @category
      render json: {success: true}, status: :ok
    else
      render json: {success: false, "message": "Error while saving", detail: @category.errors.full_messages}, status: 500
    end
  end

  def index
    render json: {success: true, categories: get_all_categories}
    rescue Exception
        render json: {"message": "Error while Processing"}, status: 500
  end

end
