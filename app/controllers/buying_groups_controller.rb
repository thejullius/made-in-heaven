class BuyingGroupsController < ApplicationController
  before_action :authenticate!
  before_action :set_buying_group, only: %i[show edit update]
  before_action :set_order_vars, :set_statuses, only: :index

  def index
    @buying_groups = BuyingGroup.where(status: @statuses)
                                .order(@order_column => @order_direction)
  end

  def show
    @batches = @buying_group.batches
    @orders = @buying_group.orders
                           .joins(:order_items)
                           .includes(:order_items)
  end

  def new
    @buying_group = BuyingGroup.new
  end

  def create
    @buying_group = BuyingGroup.new(buying_group_params)

    if @buying_group.save
      redirect_to @buying_group
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @buying_group.update(buying_group_params)
      redirect_to @buying_group
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_buying_group
      @buying_group = BuyingGroup.find(params[:id])
    end

    def set_statuses
      @statuses = [:active, :finished]
      @statuses << :inactive if current_user.admin?

      @statuses
    end

    def buying_group_params
      params.require(:buying_group).permit(:name, :date, :status)
    end
end