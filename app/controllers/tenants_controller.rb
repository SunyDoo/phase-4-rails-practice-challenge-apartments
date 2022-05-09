class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_created_response

    # GET /tenants
    def index
      tenants = Tenant.all
      render json: tenants
    end
  
    # GET /tenants/:id
    def show
      tenant = find_tenant
      render json: tenant, status: :ok
    end
  
    # POST /tenants
    def create
      tenant = Tenant.create!(tenant_params)
      render json: tenant, status: :created
    end
  
    # PATCH /tenants
    def update
      tenant = find_tenant
      tenant.update(tenant_params)
      render json: tenant, status: :accepted
    end
  
    # DELETE /tenants
    def destroy
      tenant = find_tenant
      Tenant.destroy
      head :no_content
    end
  
    private
  
    def tenant_params
      params.permit(:name, :age)
    end
  
    def find_tenant
      Tenant.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_not_created_response
        render json: { errors: "validation errors" }, status: :unprocessable_entity
    end

end