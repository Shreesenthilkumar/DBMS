create database faq_management_system;
use faq_management_system;

CREATE TABLE users (
    user_id  INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50)  UNIQUE NOT NULL,
    email    VARCHAR(100) UNIQUE NOT NULL,
    role     ENUM('admin','editor','viewer') DEFAULT 'editor'
);
INSERT INTO users (username, email, role) VALUES
  ('alice',  'alice@example.com',  'admin'),
  ('bob',    'bob@example.com',    'editor'),
  ('charlie','charlie@example.com','viewer'),
  ('diana',  'diana@example.com',  'editor'),
  ('eva',    'eva@example.com',    'admin');
  
  select * from users;
  desc users;
  
  CREATE TABLE faq_categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO faq_categories (category_name) VALUES
  ('General'),
  ('Technical'),
  ('Billing'),
  ('Login Issues'),
  ('Mobile App');
  
  select * from faq_categories;
  desc faq_categories;
  
  CREATE TABLE faq (
    faq_id     INT AUTO_INCREMENT PRIMARY KEY,
    question   VARCHAR(500) UNIQUE NOT NULL,
    answer     VARCHAR(1000) NOT NULL,
    count      INT DEFAULT 1,
    created_by INT,
    CONSTRAINT fk_user FOREIGN KEY (created_by)
                       REFERENCES users(user_id)
                       ON DELETE SET NULL
                       ON UPDATE CASCADE
);
INSERT INTO faq (question, answer, count, created_by) VALUES
  ('What is Java?', 'Java is a high-level programming language.', 1, 1),
  ('How to reset password?', 'Use the "Forgot Password" option.', 3, 2),
  ('What is an editor role?', 'Editor can manage FAQs.', 2, 3),
  ('How to install the app?', 'Visit Google Play or App Store.', 1, 4),
  ('Can I delete my account?', 'Yes, contact admin to delete it.', 1, 5);
  
  select * from faq;
  desc faq; 
  




