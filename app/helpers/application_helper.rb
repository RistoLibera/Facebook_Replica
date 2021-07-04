module ApplicationHelper
  # User image
  def avatar_for(user)
    if user.avatar.attached?
      user.avatar
    else
      "default.svg"
    end
  end

  def cover_for(user)
    if user.cover_image.attached?
      user.cover_image
    else
      "default-cover.jpg"
    end
  end
end
