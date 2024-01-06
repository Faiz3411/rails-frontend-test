class ReasonsController < ApplicationController

  before_action :set_storefront, only: [:new, :create]
  before_action :set_reason, only: [:toggle_active, :edit, :update, :destroy]
  
  def new
    @reason = @storefront.reasons.build
  end

  def create
    @reason = @storefront.reasons.build(reason_params)

    if @reason.save
      render turbo_stream: [
        turbo_stream.prepend("reasons_list", partial: "reasons/reason", locals: { reason: @reason, storefront: @storefront }),
        turbo_stream.replace("reason_modal", "")
      ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @storefront = @reason.storefront
  end

  def update
    @storefront = @reason.storefront
    if @reason.update(reason_params)
      render turbo_stream: [
        turbo_stream.replace(@reason, partial: 'reasons/reason', locals: { reason: @reason, storefront: @storefront })
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_active
    @storefront = @reason.storefront
    @reason.toggle!(:active)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def destroy
    @reason.destroy
    render turbo_stream: [
      turbo_stream.remove(@reason)
    ]
  end

  def update_order
    Reason.transaction do
      reason_order_params[:reasons].each do |param|
        reason = Reason.find(param[:id])
        reason.update!(ordering: param[:ordering])
      end
    end

    head :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  
  private

  def set_reason
    @reason = Reason.find(params[:id])
  end

  def set_storefront
    @storefront = Storefront.find(params[:storefront_id])
  end

  def reason_order_params
    params.permit(reasons: [:id, :ordering])
  end

  def reason_params
    params.require(:reason).permit(:label, :code, :active, :storefront_id)
  end

end
