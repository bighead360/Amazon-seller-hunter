class BookshopsController < ApplicationController
  before_action :set_bookshop, only: [:show, :edit, :update, :destroy]

  # GET /bookshops
  # GET /bookshops.json
  def index
    @bookshops = Bookshop.all
  end

  # GET /bookshops/1
  # GET /bookshops/1.json
  def show
  end

  # GET /bookshops/new
  def new
    @bookshop = Bookshop.new
  end

  # GET /bookshops/1/edit
  def edit
  end

  # POST /bookshops
  # POST /bookshops.json
  def create
    @bookshop = Bookshop.new(bookshop_params)

    respond_to do |format|
      if @bookshop.save
        format.html { redirect_to @bookshop, notice: 'Bookshop was successfully created.' }
        format.json { render :show, status: :created, location: @bookshop }
      else
        format.html { render :new }
        format.json { render json: @bookshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookshops/1
  # PATCH/PUT /bookshops/1.json
  def update
    respond_to do |format|
      if @bookshop.update(bookshop_params)
        format.html { redirect_to @bookshop, notice: 'Bookshop was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookshop }
      else
        format.html { render :edit }
        format.json { render json: @bookshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookshops/1
  # DELETE /bookshops/1.json
  def destroy
    @bookshop.destroy
    respond_to do |format|
      format.html { redirect_to bookshops_url, notice: 'Bookshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookshop
      @bookshop = Bookshop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookshop_params
      params.require(:bookshop).permit(:shopname , :Amazonid)
    end
end
