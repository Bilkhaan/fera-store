# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    shop = ShopsService.find_by_current_domain
    @orders = shop.orders.page(params[:page])
  end
end
