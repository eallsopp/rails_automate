CREATE TABLE 'users' (
  'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  'first_name' text NOT NULL,
  'last_name' text NOT NULL,
  'email' text UNIQUE NOT NULL,
  'username' text UNIQUE NOT NULL,
  'password' text NOT NULL,
);
