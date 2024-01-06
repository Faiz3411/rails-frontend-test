class ReasonsController < ApplicationController

  before_action :set_reason, only: [:toggle_active]

  def toggle_active
    @storefront = @reason.storefront
    @reason.toggle!(:active)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
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

  def reason_order_params
    params.permit(reasons: [:id, :ordering])
  end

end
