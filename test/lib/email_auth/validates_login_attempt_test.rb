require "test_helper"

module EmailAuth
  class ValidatesLoginAttemptTest < ActiveSupport::TestCase
    setup do
      @subject = ValidatesLoginAttempt.new
    end

    def test_valid_token
      user = User.create!(email: "a@b", auth_token: "12345", auth_token_expires_at: 1.minute.from_now)

      result = @subject.validate("12345")

      assert result.success?
      assert_equal user, result.user
    end

    def test_invalid_token
      User.create!(email: "a@b", auth_token: "54321", auth_token_expires_at: 1.minute.from_now)

      result = @subject.validate("12345")

      refute result.success?
      assert_nil result.user
    end

    def test_expired_token
      User.create!(email: "a@b", auth_token: "12345", auth_token_expires_at: 1.minute.ago)

      result = @subject.validate("12345")

      refute result.success?
      assert_nil result.user
    end
  end
end
