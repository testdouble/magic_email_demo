class LoginLinkMailer < ApplicationMailer
  def login_link
    @user = params[:user]
    @token = params[:token]
    @redirect_path = params[:redirect_path]

    mail(
      to: @user.email,
      subject: "🪄 Your Magic Login Link ✨"
    )
  end
end
