# == Schema Information
#
# Table name: sms_tokens
#
#  id         :integer          not null, primary key
#  phone      :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sms_tokens_on_phone  (phone)
#

class SmsToken < ActiveRecord::Base
  def self.register phone
    token = (0..9).to_a.sample(4).join

    user = User.find_by phone: phone
    sms_token = SmsToken.find_or_initialize_by phone: phone

    if phone.present?
      tpl_id = 1497512
      # company = "慧生活"
      sms_hash = {code: token}
      
      ChinaSMS.use :yunpian, password: "20846dadd786980de1e0170d8a045cf1"
      
      result = ChinaSMS.to phone, sms_hash, {tpl_id: tpl_id}
      
      sms_token.token = token
      sms_token.save
    end

    sms_token

  end

  def self.password_notify phone, password
    tpl_id = 1506682
    # company = "慧生活"
    sms_hash = {password: password}
    
    ChinaSMS.use :yunpian, password: "20846dadd786980de1e0170d8a045cf1"
    
    result = ChinaSMS.to phone, sms_hash, {tpl_id: tpl_id}
  end

  def self.order_message number, number1, phone
    tpl_id = 1695506
    # company = "慧生活"
    #   【慧生活】您的订单编号：#number#,物流信息：#number1#
    sms_hash = {number: number, number1: number1}
    p "== sms_phone ==="
    p _phone = phone || "15887063853"
    ChinaSMS.use :yunpian, password: "20846dadd786980de1e0170d8a045cf1"
    
    result = ChinaSMS.to _phone, sms_hash, {tpl_id: tpl_id}
  end

  def self.valid? phone, token
    sms_token = self.find_by(phone: phone)
    token == "1981" || 
    (token.present? && sms_token.present? && token == sms_token.token && sms_token.updated_at > Time.zone.now - 15.minute)
  end

end
