# == Schema Information
#
# Table name: home_blocks
#
#  id            :integer          not null, primary key
#  admin_user_id :integer
#  title         :string(191)
#  ranking       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_home_blocks_on_admin_user_id  (admin_user_id)
#

FactoryGirl.define do
  factory :home_block do
  	title_ary = ['智慧健康', '健步达人', '智慧家居', '社区活动', '社区IT', '上门服务', '精品超市', '限量发售'] 
  	sequence(:title, 0) { |n| title_ary[n] }
  	sequence(:ranking) { |n| n }
    association :home_block_cover, factory: :image, photo_type: "home_block_cover"
  end
end
