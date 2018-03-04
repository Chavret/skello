class CreatePostsAndComments
  def initialize(params)
    @posts = params[:posts]
    @comments = params[:comments]
  end

  def perform
    delete_comments
    delete_posts

    @posts.each_with_index do |post, index|
      new_post = Post.create(title: post[:title], content: post[:content], photo: post[:photo], rate: post[:rating])
      create_comment(index, new_post.id)
    end
  end

  private

  def create_comment(index, id)
    @comments[index].each do |comment|
      Comment.create(text: comment, post_id: id)
    end
  end

  def delete_comments
    Comment.destroy_all
  end

  def  delete_posts
    Post.destroy_all
  end
end
