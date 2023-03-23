# Posts Model and Repository Classes Design Recipe

## 1. The Table

```
# EXAMPLE

Table: posts

Columns:
id | title | content | comments

Table: comments

Columns:
id | content | author_name | post_id
```

## 2. Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

-- (file: spec/seeds_posts.sql)

TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content, comments) VALUES ('cat photos', 'Two years old!', 2);
INSERT INTO posts (title, content, comments) VALUES ('dog photos', 'Tuck as a puppy', 5);

INSERT INTO comments (content, author_name, post_id) VALUES ('This is great!', 'Jack', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Happy Birthday Shrimp!', 'Rachel', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Cute puppy!', 'Tez', 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. The classes

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: comments
#Model class
# (in lib/comment.rb)
class Comment
  attr_accessor :id, :content, :author_name, :post_id
end

# Table name: posts
# Model class
# (in lib/Post.rb)
class Post
  attr_accessor :id, :title, :content, :comments
  def initialize
    @comments = []
  end
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
  # Gets a single record and associated records by its ID
  # One argument: the id (number)
  def find_with_comments(id)
    # Executes the SQL query:
        # SELECT 
        #     posts.id,
        #     posts.title,
        #     posts.contents,
        #     comments.id AS comment_id,
        #     comments.content,
        #     comments.author_name
        # FROM posts
        # JOIN comments ON comments.post_id = posts.id
        # WHERE posts.id = $1;

    # Returns a single Post object containing an array of Comment objects.
  end
end

```

## 4. Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1 Returns a post with its comments
repo = PostRepository.new

# Perfoms a SELECT with a JOIN and returns an Post object.
# This object also has an attribute .comments, which is an array
# of Comment objects.
post = repo.find_with_comments(1)

post.id # => 1

post.comments.size # => 2
post.comments.last.id # 2

post = repo.find_with_comments(2)

post.id # => 2

post.comments.size # => 1
post.comments.last.id # 3

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->