class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        apartments = Apartment.all
        render json: apartments, status: 200
    end

    def show
        render json: find_apartment, status: 200
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: 201
    end

    def update
        find_apartment.update!(apartment_params)
        render json: find_apartment, status: 202
    end

    def destroy
        find_apartment.destroy
        head :no_content
    end

    private
    
    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
    end

    def render_not_found
        render json: { errors: "Apartment not found" }, status: 404
    end

end
