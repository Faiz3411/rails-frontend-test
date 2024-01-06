class ReasonsController < ApplicationController

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

  def reason_order_params
    params.permit(reasons: [:id, :ordering])
  end

end
