class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_secure_password

  after_destroy :ensure_an_admin_remains
  # after_destroy is a hook method that calls another another one after an action.
  # the way it works is if the method passed to after_destroy raises an exception
  # the last transaction will be rolled back.

  private

  def ensure_an_admin_remains

    if User.count.zero?
      raise 'Can\'t delete last user. Please go back to the users page.'
      #once ensure_an_admin_remains makes the count and states that
      # there is no more users the excepton is raised and the transaction rolled back.

    end
  end


end
