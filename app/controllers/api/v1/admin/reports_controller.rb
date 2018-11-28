# frozen_string_literal: true

class Api::V1::Admin::ReportsController < Api::BaseController
  before_action -> { doorkeeper_authorize! :'admin:read', :'admin:read:reports' }
  before_action :require_staff!
  before_action :set_reports, only: :index
  before_action :set_report, only: :show

  def index
    render json: @reports, each_serializer: REST::Admin::ReportSerializer
  end

  def show
    render json: @report, serializer: REST::Admin::ReportSerializer
  end

  private

  def set_reports
    @reports = filtered_reports.order(id: :desc)
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def filtered_reports
    ReportFilter.new(filter_params).results
  end

  def filter_params
    params.permit(
      :resolved,
      :account_id,
      :target_account_id
    )
  end
end
