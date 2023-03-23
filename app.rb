require_relative 'lib/database_connection'
require_relative 'lib/post_repository'

DatabaseConnection.connect('blog')

repo = PostRepository.new
post = repo.find_with_comments(1)
comments = ""
post.comments.each {|comment| comments << "#{comment.author_name}: #{comment.content}\n"}

puts "\nPost: #{post.title}, content: #{post.content}\n\ncomments:\n#{comments}"