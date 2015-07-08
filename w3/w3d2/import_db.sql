DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Bob', 'Johnson'), ('Deborah', 'Dragonslayer'), ('Mac', 'Donald');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Bathroom Location', 'Where is the bathroom?????',
    (SELECT id FROM users WHERE fname = 'Bob' AND lname = 'Johnson')),
  ('Ned?', 'Who is Ned? Seriously.',
    (SELECT id FROM users WHERE fname = 'Bob' AND lname = 'Johnson')),
  ('Microwave Over', "Why doesn't the microwave work at the same time as the toaster?",
    (SELECT id FROM users WHERE fname = 'Deborah' AND lname = 'Dragonslayer'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Mac' AND lname = 'Donald'),
    (SELECT id FROM questions WHERE title = 'Bathroom Location')),
  ((SELECT id FROM users WHERE fname = 'Mac' AND lname = 'Donald'),
    (SELECT id FROM questions WHERE title = 'Ned?')),
  ((SELECT id FROM users WHERE fname = 'Deborah' AND lname = 'Dragonslayer'),
    (SELECT id FROM questions WHERE title = 'Ned?'));

INSERT INTO
  replies (body, question_id, parent_id, user_id)
VALUES
  (
    "Yeah I've been trying to find it for days... gotta pee!",
    (SELECT id FROM users WHERE fname = 'Mac' AND lname = 'Donald'),
    NULL,
    (SELECT id FROM questions WHERE title = 'Bathroom Location')
  );

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Mac' AND lname = 'Donald'),
    (SELECT id FROM questions WHERE title = 'Bathroom Location'));
