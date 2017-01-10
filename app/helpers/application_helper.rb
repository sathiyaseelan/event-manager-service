module ApplicationHelper

  def index_params
    index_params = {}
    index_params[:sort_column] =  params[:col] if params[:col]
    index_params[:size] =  params[:sz] if params[:sz]
    index_params[:page_num] =  params[:pg] if params[:pg]
    index_params[:order] =  params[:ord] if params[:ord]
    index_params
  end

end
