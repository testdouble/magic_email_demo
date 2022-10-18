require "test_helper"

module EmailAuth
  class EmailsLinkTest < UnitTest
    setup do
      @finds_or_creates_user = Mocktail.of_next(FindsOrCreatesUser)
      @generates_auth_token = Mocktail.of_next(GeneratesToken)
      @delivers_email = Mocktail.of_next(DeliversEmail)

      @subject = EmailsLink.new
    end

    def test_email_was_invalid
      stubs { @finds_or_creates_user.find_or_create(:invalid_email) }.with { nil }

      @subject.email(email: :invalid_email, redirect_path: "doesnt matter")

      verify_no_calls!(@generates_auth_token, :generate)
      verify_no_calls!(@delivers_email, :deliver)
    end

    def test_no_active_token
      stubs { @finds_or_creates_user.find_or_create(:an_email) }.with { :a_user }
      stubs { @generates_auth_token.generate(:a_user) }.with { :some_token }

      @subject.email(email: :an_email, redirect_path: :some_path)

      verify {
        @delivers_email.deliver(
          user: :a_user,
          token: :some_token,
          redirect_path: :some_path
        )
      }
    end
  end
end
