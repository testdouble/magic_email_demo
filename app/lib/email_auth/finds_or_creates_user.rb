module EmailAuth
  class FindsOrCreatesUser
    def find_or_create(email)
      user = User.find_or_create_by(email: email.strip.downcase)

      if user.persisted?
        user
      end
    end
  end
end
