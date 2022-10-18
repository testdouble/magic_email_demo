require "test_helper"

module EmailAuth
  class DeliversEmailTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    setup do
      @subject = DeliversEmail.new
    end

    def test_delivers_mail
      user = User.create!(email: "foo@example.com")

      @subject.deliver(user: user, token: "123456", redirect_path: "/numbers?count=42")

      assert_equal 1, enqueued_jobs.size
      perform_enqueued_jobs
      assert_equal 1, ActionMailer::Base.deliveries.size
      mail = ActionMailer::Base.deliveries.first
      assert_equal ["foo@example.com"], mail.to
      assert_equal "🪄 Your Magic Login Link ✨", mail.subject
      assert_match(/Here is your\s+<a href=".*">link to login<\/a>/o, mail.body.to_s)
      assert_match(/It expires in #{GeneratesToken::TOKEN_SHELF_LIFE} minutes/o, mail.body.to_s)
      first_url = mail.body.to_s.match(/(http:\/\/[^\s"]*)/)&.captures&.first
      assert_equal "http://example.com/login_emails/authenticate?redirect_path=%2Fnumbers%3Fcount%3D42&amp;token=123456", first_url
    end
  end
end
