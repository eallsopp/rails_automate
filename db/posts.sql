CREATE TABLE 'posts' (
  'activity_name' varchar NOT NULL,
  'minutes_used' integer NOT NULL,
  'date' date NOT NULL default CURRENT_DATE,
  'user_id' integer REFERENCES users (id)
);