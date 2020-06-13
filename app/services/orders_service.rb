class OrdersService
  class << self
    def create_narwhal_order(shop_domain:, webhook:)
      return unless is_narwal_order?(webhook: webhook)

      shop = Shop.find_by(shopify_domain: shop_domain)

      shop.with_shopify_session do
        order = {
          order_id: webhook[:id],
          order_number: webhook[:order_number],
          ordered_by: ordered_by(webhook[:customer])
        }

        order = Order.where(order_id: order[:order_id]).first_or_create(order)
        shop.orders << order
      end
    end

    def is_narwal_order?(webhook:)
      is_narwal_order = webhook[:line_items].any? do |line_item|
        line_item[:name].downcase.include? "narwhal"
      end
      is_narwal_order
    end

    def ordered_by(customer_data)
      return 'Customer' if customer_data.nil?

      customer_name = [customer_data[:fisrt_name], customer_data[:last_name]].join(' ').strip
      customer_name = customer_data[:email] if customer_name.blank?
      customer_name = customer_data[:phone] if customer_name.blank?

      customer_name
    end
  end
end
