# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idname     :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  count      :integer
#
# Indexes
#
#  index_appointments_on_user_id  (user_id)
#

# 社区活动预约
class Appointment::Sqhd < Appointment
  def self.model_name
    Appointment.model_name
  end
end