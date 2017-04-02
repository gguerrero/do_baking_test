class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  # GET /transfers
  def index
    @transfers = Transfer.all
  end

  # GET /transfers/1
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  def create
    @transfer = Transfer.new(transfer_params)

    if @transfer.save
      redirect_to @transfer, notice: 'Transfer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /transfers/1
  def update
    if @transfer.update(transfer_params)
      redirect_to @transfer, notice: 'Transfer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /transfers/1
  def destroy
    @transfer.destroy
    redirect_to transfers_url, notice: 'Transfer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transfer_params
      params.require(:transfer).permit(:completed_at, :status_code, :status_message, :account_from_id, :account_to_id, :quantity)
    end
end
