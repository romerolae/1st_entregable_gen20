CREATE TABLE "users" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "age" int NOT NULL DEFAULT 18,
  "username" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "is_active" boolean NOT NULL DEFAULT 'false',
  "created_at" timestamp NOT NULL DEFAULT 'now',
  "updated_at" timestamp NOT NULL DEFAULT 'now',
  CHECK (char_length(password) >= 8),
    CHECK (char_length(password) <= 72),
    CHECK (password ~ '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})'),
    CHECK (email like '%_@__%.__%')
);

CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "course_name" varchar UNIQUE NOT NULL,
  "description" text,
  "level" varchar NOT NULL DEFAULT 'basic',
  "is_completed" boolean DEFAULT 'false',
  "teacher" varchar DEFAULT 'not assigned',
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL
);

CREATE TABLE "course_videos" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "course_id" uuid NOT NULL,
  "title" varchar UNIQUE NOT NULL,
  "video_url" text NOT NULL DEFAULT 'http://www.google.com'
);

CREATE TABLE "course_categories" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "course_id" uuid NOT NULL,
  "course_video_id" uuid NOT NULL,
  "name" varchar UNIQUE NOT NULL
);

CREATE TABLE "enrollments" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "course_id" uuid NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT 'NOW',
  "updated_at" TIMESTAMP NOT NULL DEFAULT 'NOW'
);

CREATE TABLE "certificates" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "name" varchar UNIQUE NOT NULL,
  "course_id" uuid NOT NULL,
  "date_certificate" TIMESTAMP NOT NULL
);

CREATE TABLE "assignments" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "assignment_name" varchar UNIQUE NOT NULL,
  "course_id" uuid NOT NULL,
  "due_date" TIMESTAMP NOT NULL DEFAULT 'undefined',
  "instructions" text
);

CREATE TABLE "grades" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "enrollment_id" uuid NOT NULL,
  "score" float,
   CHECK (score >= 0 AND score <= 100),
);

CREATE TABLE "attendance" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "course_id" uuid not null,
  "atte_average" float NOT NULL
);

ALTER TABLE "enrollments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "attendance" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "course_videos" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "course_categories" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "course_categories" ADD FOREIGN KEY ("course_video_id") REFERENCES "course_videos" ("id");

ALTER TABLE "certificates" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "enrollments" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "assignments" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "grades" ADD FOREIGN KEY ("enrollment_id") REFERENCES "enrollments" ("id");

ALTER TABLE "attendance" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");



insert into "enrollments" ("user_id", "course_id") VALUES
('aea81229-f1d3-42c3-854d-f98c308c49e2', '01c57555-f246-4a39-b960-981bfa256f8d'),
('0ba8e88c-eb77-45ff-8d89-150e929c7d05', 'e05c7ae5-b393-4444-95f6-34b6b97e639f'),
('f5e5ec7e-d97c-4863-a1be-44787ff00ca5', '8eac0f73-c8ad-4929-9b2c-63007fd22f00'),
('e84554bf-3faa-4cf7-89cf-6ba76a6d6436', '3ff88174-1a23-48b0-a79b-badace914afd'),
('ddf9b7b3-04cb-4818-a175-2f091eb8b347', '631d0b7d-8fe6-4893-abf7-e9a1f415d70d');


INSERT INTO "users" ("name", "last_name", "age", "username", "password", "email", "is_active") VALUES 
('Alex', 'Parker', 20, 'alexparker', 'Alexparker1!', 'alexparker@example.com', true),
('Sophia', 'Miller', 25, 'sophiamiller', 'Sophiamiller2!', 'sophiamiller@example.com', true),
('James', 'Davis', 30, 'jamesdavis', 'Jamesdavis3!', 'jamesdavis@example.com', true),
('Emily', 'Garcia', 35, 'emilygarcia', 'Emilygarcia4!', 'emilygarcia@example.com', true),
('Daniel', 'Rodriguez', 40, 'danielrodriguez', 'Danielrodriguez5!', 'danielrodriguez@example.com', true);


INSERT INTO "course_videos" ("course_id", "title", "video_url") VALUES 
('857e8caa-ef59-4b50-ae2c-0810deb5b67a', 'JavaScript Fundamentals - Video 6', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
('206a5b9d-71b2-499a-9c66-4e0595ac78bd', 'SQL for Beginners - Video 7', 'https://www.youtube.com/watch?v=HXV3zeQKqGY'),
('b51589ce-a6dc-4cbd-a6b9-3361d4ebe806', 'Python Programming - Video 8', 'https://www.youtube.com/watch?v=_Z1eLJJaCmE'),
('dbe6ef6c-9483-44f3-bc13-ca44a5e4b9ac', 'Django Framework - Video 9', 'https://www.youtube.com/watch?v=2uOgDYKdGcM'),
('2f7c0746-ef88-4eae-b91c-50ee79cbebce', 'Node.js Fundamentals - Video 10', 'https://www.youtube.com/watch?v=t5ykbFkpKt8');


INSERT INTO "assignments" ("course_id", "assignment_name", "due_date", "instructions") VALUES 
('01c57555-f246-4a39-b960-981bfa256f8d', 'Assignment 1', '2022-01-01', 'Write a 500 word essay on the history of the internet'),
('e05c7ae5-b393-4444-95f6-34b6b97e639f', 'Assignment 2', '2022-02-01', 'Create a presentation on the future of renewable energy'),
('8eac0f73-c8ad-4929-9b2c-63007fd22f00', 'Assignment 3', '2022-03-01', 'Design a website for a local small business'),
('3ff88174-1a23-48b0-a79b-badace914afd', 'Assignment 4', '2022-04-01', 'Create a mobile app to track personal expenses'),
('631d0b7d-8fe6-4893-abf7-e9a1f415d70d', 'Assignment 5', '2022-05-01', 'Research and write a report on the current state of healthcare in a specific country'),
('857e8caa-ef59-4b50-ae2c-0810deb5b67a', 'Assignment 6', '2022-06-01', 'Write a script for a short film');

INSERT INTO "attendance" ("user_id", "course_id", "atte_average") VALUES
('aea81229-f1d3-42c3-854d-f98c308c49e2', '01c57555-f246-4a39-b960-981bfa256f8d', 0.90),
('0ba8e88c-eb77-45ff-8d89-150e929c7d05', 'e05c7ae5-b393-4444-95f6-34b6b97e639f', 0.85),
('f5e5ec7e-d97c-4863-a1be-44787ff00ca5', '8eac0f73-c8ad-4929-9b2c-63007fd22f00', 0.80),
('e84554bf-3faa-4cf7-89cf-6ba76a6d6436', '3ff88174-1a23-48b0-a79b-badace914afd', 0.75),
('ddf9b7b3-04cb-4818-a175-2f091eb8b347', '631d0b7d-8fe6-4893-abf7-e9a1f415d70d', 0.70);

INSERT INTO "certificates" ("name", "course_id", "date_certificate") VALUES
('Introduction to Programming', '01c57555-f246-4a39-b960-981bfa256f8d', '2022-10-01'),
('Web Development 101', 'e05c7ae5-b393-4444-95f6-34b6b97e639f', '2022-11-15'),
('Data Structures and Algorithms', '8eac0f73-c8ad-4929-9b2c-63007fd22f00', '2022-12-01'),
('Advanced Machine Learning', '3ff88174-1a23-48b0-a79b-badace914afd', '2023-01-10'),
('Cloud Computing Fundamentals', '631d0b7d-8fe6-4893-abf7-e9a1f415d70d', '2023-02-01');

INSERT INTO "course_categories" ("course_id", "course_video_id", "name") VALUES
('01c57555-f246-4a39-b960-981bfa256f8d', '5f973c8d-7c10-4f0e-94c7-ef9d75d42339', 'Introduction to Programming'),
('e05c7ae5-b393-4444-95f6-34b6b97e639f', 'f5ea0c71-3e84-4e32-ba14-af33b175feb3', 'Web Development 101'),
('8eac0f73-c8ad-4929-9b2c-63007fd22f00', 'a11fbc7a-a4dd-4545-9f36-2e13c38f65e2', 'Data Structures and Algorithms'),
('3ff88174-1a23-48b0-a79b-badace914afd', '59d93409-a50a-4e16-8d6e-12a6f5a9ed32', 'Advanced Machine Learning'),
('631d0b7d-8fe6-4893-abf7-e9a1f415d70d', '221215b3-0225-49c5-bb86-905e1cc83701', 'Cloud Computing Fundamentals');


INSERT INTO "grades" ("enrollment_id", "score") VALUES 
('ea3b53b4-3d1e-424f-ba2c-88800596afc4', 95), 
('8218b552-c8dd-4367-83d8-0fdd630ee71a', 93), 
('b9e1c0f4-7f85-4660-824a-224f50357977', 88), 
('a5e42ecd-a73a-4bff-87ac-2093b3145ff3', 96), 
('81bb55cd-e90d-4868-83d6-540bf6dc5267', 97);

