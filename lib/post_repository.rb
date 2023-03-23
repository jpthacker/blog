require_relative 'post'
require_relative 'comment'

class PostRepository
    def find_with_comments(id)
        sql = '
        SELECT 
        posts.id,
        posts.title,
        posts.content,
        comments.id AS comment_id,
        comments.content,
        comments.author_name
    FROM posts
    JOIN comments ON comments.post_id = posts.id
    WHERE posts.id = $1;
    '
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        record = result[0]
        post = Post.new
        post.id = record['id']
        post.title = record['title']
        post.content = record['content']

        result.each do |record|
            comment = Comment.new
            comment.id = record['comment_id']
            comment.content = record['content']
            comment.author_name = record['author_name']
            post.comments << comment
        end
        return post
    end
end