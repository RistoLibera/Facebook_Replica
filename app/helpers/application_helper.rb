module ApplicationHelper
  def avatar_for(user)
    if user.avatar.attached?
      user.avatar
    else
      "male_default.png"
    end
  end

  def cover_for(user)
    if user.cover_image.attached?
      user.cover_image
    else
      "male_default.png"
    end
  end
end
