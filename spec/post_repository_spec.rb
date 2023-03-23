require "post_repository"

def reset_posts_table
    seed_sql = File.read("spec/seeds_posts.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "blog_test" })
    connection.exec(seed_sql)
end

RSpec.describe PostRepository do
    before(:each) { reset_posts_table }
    it "Returns a post with its comments" do
        repo = PostRepository.new
        post = repo.find_with_comments(1)
        expect(post.id).to eq "1"
        expect(post.comments.size).to eq 2
        expect(post.comments.last.id).to eq "2"
    end
end
