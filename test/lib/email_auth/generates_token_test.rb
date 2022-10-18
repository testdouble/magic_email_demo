require "test_helper"

module EmailAuth
  class GeneratesTokenTest < ActiveSupport::TestCase
    setup do
      @subject = GeneratesToken.new
    end

    def test_token_is_nil
      user = User.new(auth_token: nil, auth_token_expires_at: nil, email: "a@a")

      result = @subject.generate(user)

      assert_looks_like_a_token result
      assert_equal user.reload.auth_token, result
      assert_in_delta user.reload.auth_token_expires_at, GeneratesToken::TOKEN_SHELF_LIFE.minutes.from_now, 1
    end

    def test_token_is_expired
      token = "a" * 22
      user = User.new(auth_token: token, auth_token_expires_at: 1.second.ago, email: "a@a")

      result = @subject.generate(user)

      refute_equal token, result
      assert_looks_like_a_token result
      assert_equal user.reload.auth_token, result
      assert_in_delta user.reload.auth_token_expires_at, GeneratesToken::TOKEN_SHELF_LIFE.minutes.from_now, 1
    end

    def test_token_is_active
      token = "b" * 22
      expiry = 1.minute.from_now
      user = User.create!(auth_token: token, auth_token_expires_at: expiry, email: "a@a")

      result = @subject.generate(user)

      assert_equal token, result
      assert_equal user.reload.auth_token, result
      assert_in_delta user.reload.auth_token_expires_at, expiry, 1
    end

    private

    def assert_looks_like_a_token(token)
      assert_equal 22, token.size
      assert_equal CGI.escape(token), token
      assert_match(/^[a-zA-Z0-9\-_]{22}$/, token)
    end
  end
end
