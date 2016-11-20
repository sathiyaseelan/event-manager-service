class CategoriesController < ApplicationController
  include CategoriesHelper

  def new
    @category = Category.new(name: params[:name])
    if @category.valid? && @category.save
      add_to_categories @category
      render json: {"message": "success"}, status: :ok
    else
      render json: {"message": "Error while saving", detail: @category.errors.full_messages}, status: 500
    end
  end

  def index

    render json: get_all_categories
    rescue Exception
        render json: {"message": "Error while Processing"}, status: 500

  end

end
