module Api
  class PagarmeController < Api::ApiController
    def update
      order = Order.find(id: order_id)
      order.update!(status: "paid")
      head :ok
    end

    private
    def order_id
      params[:order][:items][0][:id]
    end
  end
end
