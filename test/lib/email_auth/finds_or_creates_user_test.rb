require "test_helper"

module EmailAuth
  class FindsOrCreatesUserTest < ActiveSupport::TestCase
    AN_EMAIL = "foo@example.com"

    setup do
      @subject = FindsOrCreatesUser.new
    end

    def test_user_exists
      user = User.create!(email: AN_EMAIL)

      result = @subject.find_or_create(AN_EMAIL)

      assert_equal user, result
    end

    def test_user_does_not_exist
      result = @subject.find_or_create("   Some@junk.com \n ")

      assert_kind_of User, result
      refute_nil result.id
      assert_equal "some@junk.com", result.email
    end

    def test_user_does_not_exist_and_email_is_invalid
      result = @subject.find_or_create("emailatplacedotcom")

      assert_nil result
      assert_equal 0, User.count
    end
  end
end
