class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_for_oauth(auth)
    where(provider: auth['provider']).
    where(uid: auth['uid']).
    first
  end

  def self.create_for_oauth(auth)
    create(user_id: auth['uid'], provider: auth['provider'])
  end
end