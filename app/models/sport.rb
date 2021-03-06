# == Schema Information
#
# Table name: sports
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  date           :date
#  count          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  platform       :string
#  version        :integer
#  subdistrict_id :integer
#
# Indexes
#
#  index_sports_on_date     (date)
#  index_sports_on_user_id  (user_id)
#

class Sport < ActiveRecord::Base
  ######   注:  新的迁移需要 同步对子表操作  #######
  belongs_to :user

  before_save :cal_relations

  by_star_field :date

  scope :filter_date, ->(date) { where(date: date) }
  scope :subdistrict_is, ->(subdistrict_id) { where(subdistrict_id: subdistrict_id)}
  
  # validates_uniqueness_of :date, scope: :user_id
  # validates_presence_of :version
  # validate :count_validate

  def tag
    date.to_s
  end

  def rank
    self.class.where(date: date).where("count > :count", count: count).count + 1
  end

  private

    def count_validate
      increase = self.count.to_i - self.count_was.to_i
      if increase < 0
        self.errors.add(:count, "运动步数不能比原来少")
      elsif increase > 60000
        self.errors.add(:count, "一天的运动步数过多")
      else
        seconds = Time.zone.now - Time.zone.today.midnight
        count_per_second = self.count == 0 || self.count.nil? ? 0 : self.count / seconds
        self.errors.add(:count, "运动的步数太频繁") if count_per_second > 1
      end
    end

    def cal_relations
      increase = self.count.to_i - self.count_was.to_i
      logger.info "=============user is:#{self.user.phone}, increase is: #{increase}==================="
      if increase > 0
        cal_weekly increase
        cal_monthly increase
        cal_yearly increase
      end
    end

    def cal_weekly increase
      year = self.date.year
      cweek = self.date.cweek
      # sport = Sport::Weekly.subdistrict_is(self.subdistrict_id).where(user: self.user, year: year, cweek: cweek).first_or_initialize
      sport = Sport::Weekly.get_const(user.subdistrict_id).where(user: self.user, year: year, cweek: cweek).first_or_initialize
      logger.info "+++++++"
      logger.info "#{sport}"
      sport.increment :count, increase
      logger.info "+++++++" unless sport.save
    end

    def cal_monthly increase
      year = self.date.year
      month = self.date.month
      sport = Sport::Monthly.get_const(user.subdistrict_id).where(user: self.user, year: year, month: month).first_or_initialize
      logger.info "+++++++"
      logger.info "#{sport}"
      sport.increment :count, increase
      logger.info "+++++++" unless sport.save
    end

    def cal_yearly increase
      year = self.date.year
      sport = Sport::Yearly.get_const(user.subdistrict_id).where(user: self.user, year: year).first_or_initialize
      logger.info "+++++++"
      logger.info "#{sport}"
      sport.increment :count, increase
      logger.info "+++++++" unless sport.save
    end
    
end 
