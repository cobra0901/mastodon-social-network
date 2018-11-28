# frozen_string_literal: true

class REST::Admin::ReportSerializer < ActiveModel::Serializer
  attributes :id, :action_taken, :comment, :created_at, :updated_at,
             :account_id, :target_account_id, :assigned_account_id,
             :action_taken_by_account_id

  has_many :statuses, serializer: REST::StatusSerializer

  def id
    object.id.to_s
  end

  def account_id
    object.account_id.to_s.presence
  end

  def target_account_id
    object.target_account_id.to_s.presence
  end

  def assigned_account_id
    object.assigned_account_id.to_s.presence
  end

  def action_taken_by_account_id
    object.action_taken_by_account_id.to_s.presence
  end
end
