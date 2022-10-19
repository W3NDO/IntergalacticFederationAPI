class ResourcesController < ApplicationController
  before_action :set_resource, only: %i[ show update destroy ]
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # GET /resources
  def index
    @resources = Resource.all

    render json: {data: @resources}, status: :ok
  end

  # GET /resources/1
  def show
    render json: {resource: @resources}, status: :ok if @resource
  end

  # POST /resources
  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      render json: {resource: @resource}, status: :created
    else
      render json: {errors: @resource.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resources/1
  def update
    if @resource.update(resource_params)
      render json: {resource: @resource}, status: :ok
    else
      render json: {errors: @resource.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy
    render json: {message: "Successfully deleted" }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id]) || nil
    end

    # Only allow a list of trusted parameters through.
    def resource_params
      params.require(:resource).permit(:name, :weight)
    end
end