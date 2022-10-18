module EmailAuth
  class DeliversEmail
    def deliver(user:, token:, redirect_path:)
      LoginLinkMailer.with(
        user: user,
        token: token,
        redirect_path: redirect_path
      ).login_link.deliver_later
    end
  end
end
