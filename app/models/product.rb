# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  title           :string
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  count           :integer
#  detail          :text
#  state           :integer
#  product_sort_id :integer
#  after_discount  :float
#  expiration_time :datetime
#  product_type    :integer          default(0)
#  subdistrict_id  :integer
#  initial_sales   :integer          default(0)
#

class Product < ActiveRecord::Base

	include AASM
  
  has_one :product_cover, -> { where photo_type: "product_cover" }, class_name: "Image", as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :product_cover, allow_destroy: true
  has_one :product_detail, -> { where photo_type: "product_detail" }, class_name: "Image", as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :product_detail, allow_destroy: true
 
  has_many :product_banners
  has_many :cart_items
  belongs_to :product_sort
  
  belongs_to :subdistrict
  scope :subdistrict_is, ->(subdistrict_id){where(subdistrict_id: subdistrict_id)}
  scope :subdistrict_with_token, ->(token){where(subdistrict_id: token.nil? ? Subdistrict.first.id : User.where(authentication_token: token).first.subdistrict_id)}

  validates_presence_of :price, on: :create, message: "商品价格不能为空"
  validates_numericality_of :price, greater_than: 0, message: "商品价格必须是数字"
  validates_presence_of :after_discount, on: :create, message: "商品折后价格不能为空"
  validates_numericality_of :after_discount, greater_than: 0, message: "商品折后价格必须是数字"
  validates_numericality_of :count, greater_than_or_equal_to: 0, only_integer: true, message: "库存必须是正整数"

  # 精品超市
  # default_scope 会改变其他模型对该模型的关联查询{ where( product_type: 0 ) }
  scope :supermarket, -> {where(product_type: 0)}
  # 限量销售
  scope :promotion, -> {where(product_type: 1)}
  
  scope :subdistrict_id, ->(id){where(subdistrict_id: id)}
  scope :state_is, -> (state) {where(state: state)}
  scope :for_sale, -> {where(state: 1)}
  scope :product_sort_is, -> (id) {where(product_sort_id: id)}

  enum product_type: {
    supermarket: 0,
    promotion: 1,
  }

  enum state: {
    for_sale: 0,
    sale_off: 1,
  }

  aasm column: :state, enum: true do
    state :for_sale, initial: true
    state :sale_off

    event :sold_out do
      transitions from: :for_sale, to: :sale_off
    end
  end

  def state_alias
    I18n.t :"product_state.#{state}"
  end

  def sort
  # 定义方法 activeadmin中可以使用为 f.input :sort
  # 不做任何数据库操作，仅占位
    self.product_sort.try(:title)
  end

  def discount_rate
    self.after_discount ? (self.after_discount / self.price).round(2) : nil
  end
  # def after_discount
  #   (self.price * self.discount_rate).round(1)
  # end

  def sales #销量
    _sum = self.initial_sales
    self.cart_items.state_is(2).each { |cart_item| _sum += cart_item.count }
    _sum 
  end
end
