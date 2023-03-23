CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    content text,
    author_name text,
    -- The foreign key name is always {other_table_singular}_id
    post_id int,
    constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);