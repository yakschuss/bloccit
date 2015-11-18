include RandomData

50.times do

    Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph
    )
end

posts = Post.all

100.times do
    Comment.create!(

    post: posts.sample,
    body: RandomData.random_paragraph,
    )

end


a_one_of_a_kind_post = Post.find_or_create_by!(
                title: "This is one of a kind!",
                body: "So is this!"
                )


a_one_of_a_kind_comment =  Comment.find_or_create_by!(
                body: "this is unique",
                post: a_one_of_a_kind_post
                )


puts "Seed finished!"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
