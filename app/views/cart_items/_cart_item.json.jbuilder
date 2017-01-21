json.extract! cart_item, :id, :product_id, :amount, :count, :state, :state_alias, :title, :price, :discount_rate, :after_discount, :product_sort, :sales, :created_at, :subdistrict_id
json.stock cart_item.product.count
json.thumb image_url cart_item.product.try(:product_cover).try(:url, :medium)