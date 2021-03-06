class RanksController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :html, :json

  def daily
    @date = Time.zone.today
    @relations = Sport.get_const(current_user.subdistrict_id).filter_date(@date)
    @top_sports = top_sports
    respond_with(@top_sports, template: "ranks/index")
  end

  def weekly
    @date = Time.zone.today
    @relations = Sport::Weekly.get_const(current_user.subdistrict_id).filter_date(@date)
    @top_sports = top_sports
    respond_with(@top_sports, template: "ranks/index")
  end

  def monthly
    @date = Time.zone.today
    @relations = Sport::Monthly.get_const(current_user.subdistrict_id).filter_date(@date)
    @top_sports = top_sports
    respond_with(@top_sports, template: "ranks/index")
  end

  def yearly
    @date = Time.zone.today
    @relations = Sport::Yearly.get_const(current_user.subdistrict_id).filter_date(@date)
    @top_sports = top_sports
    respond_with(@top_sports, template: "ranks/index")
  end

  private
    def top_sports
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10
      @relations.order(count: :desc).paginate(page: @page, per_page: @per_page)
    end
end
