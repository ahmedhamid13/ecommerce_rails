class ImagePresenter

    def initialize(user)
      @user = user
    end

    def image
        unless @user.nil?
            if @user.avatar.attached?
                @user.avatar
            elsif @user.superadmin_role?
                "admin.png"
            else
                "avatar.svg"
            end
        end
    end
end
  