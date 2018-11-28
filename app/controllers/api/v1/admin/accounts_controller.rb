# frozen_string_literal: true

class Api::V1::Admin::AccountsController < Api::BaseController
  before_action -> { doorkeeper_authorize! :'admin:read', :'admin:read:accounts' }
  before_action :require_staff!
  before_action :set_accounts, only: :index
  before_action :set_account, only: :show

  def index
    render json: @accounts, each_serializer: REST::Admin::AccountSerializer
  end

  def show
    render json: @account, serializer: REST::Admin::AccountSerializer
  end

  private

  def set_accounts
    @accounts = filtered_accounts
  end

  def set_account
    @account = Account.find(params[:id])
  end

  def filtered_accounts
    AccountFilter.new(filter_params).results
  end

  def filter_params
    params.permit(
      :local,
      :remote,
      :by_domain,
      :active,
      :silenced,
      :suspended,
      :username,
      :display_name,
      :email,
      :ip,
      :staff
    )
  end
end
