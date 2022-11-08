class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        tenants = Tenant.all
        render json: tenants, status: 200
    end

    def show
       render json: find_tenant, status: 200
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: 201
    end

    def update
        find_tenant.update!(tenant_params)
        render json: find_tenant, status: 202
    end
    
    def destroy
        find_tenant.destroy
        head :no_content
    end

    private

    def find_tenant
        Tenant.find_by(id: params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found
        render json: { error: "Tenant Not Found" }, status: 404
    end
end
