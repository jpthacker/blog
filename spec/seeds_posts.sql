TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content, comments) VALUES ('cat photos', 'Two years old!', 2);
INSERT INTO posts (title, content, comments) VALUES ('dog photos', 'Tuck as a puppy', 5);

INSERT INTO comments (content, author_name, post_id) VALUES ('This is great!', 'Jack', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Happy Birthday Shrimp!', 'Rachel', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Cute puppy!', 'Tez', 2);