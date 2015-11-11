class Post < ActiveRecord::Base
  has_many :comments

    @posts = Post.all
    @posts.each_with_index do |post, index|
    if index % 5 == 4 
      post.update_attributes(title: 'SPAM')
    end
  end
end
