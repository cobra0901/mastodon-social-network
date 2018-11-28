# frozen_string_literal: true

class REST::Admin::AccountSerializer < ActiveModel::Serializer
  attributes :id, :username, :domain, :url, :created_at,
             :email, :ip, :role, :confirmed, :suspended,
             :silenced, :disabled

  def id
    object.id.to_s
  end

  def url
    ActivityPub::TagManager.instance.url_for(object)
  end

  def email
    object.user_email
  end

  def ip
    object.user_current_sign_in_ip.to_s.presence
  end

  def role
    object.user_role
  end

  def confirmed
    object.user_confirmed?
  end

  def disabled
    object.user_disabled?
  end
end
