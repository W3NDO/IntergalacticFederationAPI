class PilotsController < ApplicationController

  # GET /pilots
  def index
    @pilots = Pilot.all

    render json: @pilots
  end

  # GET /pilots/1
  def show
    render json: @pilot
  end

  # POST /pilots
  def create
    render json: message: "Certification is invalid", status: :unprocessable_entity unless certificate_valid?(pilot_params[:certification])
    @pilot = Pilot.new(pilot_params)

    if @pilot.save
      render json: {data: @pilot, status: "SUCCESS", message: "Pilot successfully created"}, status: :ok
    else
      render json: {status: "FAILURE", message: @pilot.errors, status: :unprocessable_entity}
    end
  end

  # PATCH/PUT /pilots/1
  def update
    if @pilot.update(pilot_params)
      render json: {data: @pilot, status: "SUCCESS", message: "Pilot successfully updated"}, status: :ok
    else
      render json: {status: "FAILURE", message: @pilot.errors, status: :unprocessable_entity}
    end
  end

  # DELETE /pilots/1
  def destroy
    if @pilot.destroy
        render json: {status: "SUCCESS", message: "Pilot successfully deleted"}, status: :ok
    else
      render json: {status: "FAILURE", message: @pilot.errors, status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pilot
      @pilot = pilot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pilot_params
      params.require(:pilot).permit(:certificaiton, :name, :age, :credits, :location_planet)
    end

    def certificate_valid?(certification)
        # validates that the certification is legitimate using Luhn Validation
        digits = certification.digits
        digits.each_with_index do |num, index|
            if index.odd?
                temp = digits[6-index]*2
                while temp > 9 do
                    temp = temp.digits.sum
                end
                digits[6-index] = temp
            end
        end
        digits.sum % 10 == 0
    end
end
