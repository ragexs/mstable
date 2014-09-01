class AvrsController < ApplicationController
  before_action :set_avr, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :index, :create, :update, :destroy]

  # GET /avrs
  # GET /avrs.json
  def index
    @avrs = Avr.all
  end

  # GET /avrs/1
  # GET /avrs/1.json
  def show
  end

  # GET /avrs/new
  def new
    @avr = Avr.new
  end

  # GET /avrs/1/edit
  def edit
  end

  # POST /avrs
  # POST /avrs.json
  def create
    @avr = Avr.new(avr_params)

    respond_to do |format|
      if @avr.save
        format.html { redirect_to @avr, notice: 'Avr was successfully created.' }
        format.json { render :show, status: :created, location: @avr }
      else
        format.html { render :new }
        format.json { render json: @avr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avrs/1
  # PATCH/PUT /avrs/1.json
  def update
    respond_to do |format|
      if @avr.update(avr_params)
        format.html { redirect_to @avr, notice: 'Avr was successfully updated.' }
        format.json { render :show, status: :ok, location: @avr }
      else
        format.html { render :edit }
        format.json { render json: @avr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avrs/1
  # DELETE /avrs/1.json
  def destroy
    @avr.destroy
    respond_to do |format|
      format.html { redirect_to avrs_url, notice: 'Avr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avr
      @avr = Avr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avr_params
      params.require(:avr).permit(:mmm_id, :type_avr, :material, :comment, :user_id, :date_on, :date_off)
    end
end
