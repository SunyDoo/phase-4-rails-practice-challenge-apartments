class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    # GET /apartments
    def index
      apartments = Apartment.all
      render json: apartments
    end
  
    # GET /apartments/:id
    def show
      apartment = find_apartment
      render json: apartment, status: :ok
    end
  
    # POST /apartments
    def create
      apartment = Apartment.create!(apartment_params)
      render json: apartment, status: :created
    end
  
    # PATCH /apartments
    def update
      apartment = find_apartment
      apartment.update(apartment_params)
      render json: apartment, status: :accepted
    end
  
    # DELETE /apartments
    def destroy
      apartment = find_apartment
      apartment.destroy
      head :no_content
    end
  
    private
  
    def apartment_params
      params.permit(:number)
    end
  
    def find_apartment
      Apartment.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "apartment not found" }, status: :not_found
    end

    def render_not_created_response
        render json: { errors: "validation errors" }, status: :unprocessable_entity
    end

end