class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private 

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def render_not_created_response
        render json: { errors: "validation errors" }, status: :unprocessable_entity
    end


end
