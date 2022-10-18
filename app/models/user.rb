class User < ApplicationRecord
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
end
