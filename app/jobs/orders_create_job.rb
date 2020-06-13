class OrdersCreateJob < ActiveJob::Base
  queue_as :default

  def perform(shop_domain:, webhook:)
    OrdersService.create_narwhal_order(shop_domain: shop_domain, webhook: webhook)
  end
end
