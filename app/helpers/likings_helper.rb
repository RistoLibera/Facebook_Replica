module LikingsHelper

  def has_liking?(post)
    post.likings.any? { |liking| liking.user_id == current_user.id }
  end

  def current_liking(post)
    cl = current_user.likings.find_by(post_id: post.id)
    return cl
  end
end
