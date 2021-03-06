require 'csv'
class AttractivesController < ApplicationController
  before_action :set_attractive, only: [:show, :edit, :update, :destroy]

  def loadAttractivesFromCsv
        csvFile = File.read("atractivos.csv")
        CSV.parse(csvFile, { headers: true, col_sep: "#" }).each do | row |
          currentType = Type.getTypeIdFromType row["TIPO"]
          Attractive.create(name: row["NOMBRE"], description: row["DESCRIPCION"], address: row["DIRECCION"], web: row["WEB"], telephone: row["TELEFONO"], latitude: row["LATITUD"], longitude: row["LONGITUD"], type_id: currentType.id, schedule: row["HORARIO"])
        end
  end

  # GET /attractives
  # GET /attractives.json
  def index
    @attractives = Attractive.all
  end

  # GET /attractives/1
  # GET /attractives/1.json
  def show
  end

  def showByTypeId
    @attractives = Attractive.where(:type_id => params[:id])
  end

  # GET /attractives/new
  def new
    @attractive = Attractive.new
  end

  # GET /attractives/1/edit
  def edit
  end

  # POST /attractives
  # POST /attractives.json
  def create
    @attractive = Attractive.new(attractive_params)

    respond_to do |format|
      if @attractive.save
        format.html { redirect_to @attractive, notice: 'Attractive was successfully created.' }
        format.json { render :show, status: :created, location: @attractive }
      else
        format.html { render :new }
        format.json { render json: @attractive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attractives/1
  # PATCH/PUT /attractives/1.json
  def update
    respond_to do |format|
      if @attractive.update(attractive_params)
        format.html { redirect_to @attractive, notice: 'Attractive was successfully updated.' }
        format.json { render :show, status: :ok, location: @attractive }
      else
        format.html { render :edit }
        format.json { render json: @attractive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attractives/1
  # DELETE /attractives/1.json
  def destroy
    @attractive.destroy
    respond_to do |format|
      format.html { redirect_to attractives_url, notice: 'Attractive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attractive
      @attractive = Attractive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attractive_params
      params.require(:attractive).permit(:name, :description, :address, :web, :telephone, :latitude, :longitude, :type_id, :schedule)
    end
end
