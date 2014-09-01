class MmmsController < ApplicationController
  before_action :set_mmm, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:show, :index, :create, :update, :destroy]
  # GET /mmms
  # GET /mmms.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: MmmsDatatable.new(view_context) }
    end
  end

  # GET /mmms/1
  # GET /mmms/1.json
  def show
  end

  # GET /mmms/new
  def new
    @mmm = Mmm.new
  end

  # GET /mmms/1/edit
  def edit
  end

  # POST /mmms
  # POST /mmms.json
  def create
    @mmm = Mmm.new(mmm_params)

    respond_to do |format|
      if @mmm.save
        format.html { redirect_to @mmm, notice: 'Mmm was successfully created.' }
        format.json { render :show, status: :created, location: @mmm }
      else
        format.html { render :new }
        format.json { render json: @mmm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mmms/1
  # PATCH/PUT /mmms/1.json
  def update
    respond_to do |format|
      if @mmm.update(mmm_params)
        format.html { redirect_to @mmm, notice: 'Mmm was successfully updated.' }
        format.json { render :show, status: :ok, location: @mmm }
      else
        format.html { render :edit }
        format.json { render json: @mmm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mmms/1
  # DELETE /mmms/1.json
  def destroy
    @mmm.destroy
    respond_to do |format|
      format.html { redirect_to mmms_url, notice: 'Mmm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mmm
      @mmm = Mmm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mmm_params
      params.require(:mmm).permit(:mdu, :adress, :porch, :ip, :sys_name, :ingress, :mod)
    end
end
