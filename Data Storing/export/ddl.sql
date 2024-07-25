ALTER DATABASE stackoverflow CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
create table users(
    user_id bigint primary key auto_increment,
    username varchar(255),
    reputation bigint 
);

create table tags(
    tag_id varchar(255) primary key,
    tag_name varchar(255),
    total_questions bigint
);
create table tag_users(
    user_id bigint,
    tag_id varchar(255),
    primary key (user_id, tag_id),
    foreign key (user_id) references users(user_id),
    foreign key (tag_id) references tags(tag_id)
);

create table questions(
    question_id bigint primary key auto_increment,
    title varchar(255),
    body text,
    link varchar(255),
    score bigint,
    questioner_id bigint,
    foreign key (questioner_id) references users(user_id)
);

create table question_tag(
    tag_id varchar(255),
    question_id bigint,
    primary key (tag_id, question_id),
    foreign key (tag_id) references tags(tag_id),
    foreign key (question_id) references questions(question_id)
);

create table answers(
    question_id bigint,
    answer_id bigint,
    body text,
    score bigint,
    answerer_id bigint,
    primary key (question_id, answer_id),
    foreign key (question_id) references questions(question_id),
    foreign key (answerer_id) references users(user_id)
);

create table comments(
    comment_id bigint primary key,
    body text
);

create table question_comment(
    question_id bigint,
    user_id bigint,
    comment_id bigint,
    primary key (question_id, user_id, comment_id),
    foreign key (question_id) references questions(question_id),
    foreign key (user_id) references users(user_id),
    foreign key (comment_id) references comments(comment_id)
);


create table answer_comment(
    question_id bigint,
    answer_id bigint,
    user_id bigint,
    comment_id bigint,
    primary key (question_id, user_id, comment_id),
    foreign key (question_id, answer_id) references answers(question_id, answer_id),
    foreign key (user_id) references users(user_id),
    foreign key (comment_id) references comments(comment_id)
);




