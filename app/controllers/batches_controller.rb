class BatchesController < ::ApplicationController
  before_action :authenticate!, :set_buying_group

  def new
    @batch = @buying_group.batches.build
  end

  def create
    @batch = @buying_group.batches.build(batch_params)

    if @batch.save
      redirect_to @buying_group
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @batch = @buying_group.batches.find(params[:id])
  end

  def update
    @batch = @buying_group.batches.find(params[:id])

    if @batch.update(batch_params)
      redirect_to @buying_group
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def set_buying_group
      @buying_group = BuyingGroup.find(params[:buying_group_id])
    end

    def batch_params
      params.require(:batch).permit(:buying_group_id, :description, :amount, :quantity)
    end
end