class ShopsService
  class << self
    def find_by_current_domain
      shopify_shop = ShopifyAPI::Shop.current
      Shop.find_by(shopify_domain: shopify_shop.domain)
    end
  end
end
