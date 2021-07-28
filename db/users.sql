CREATE TABLE 'users' (
  'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  'username' text UNIQUE NOT NULL,
  'password' text NOT NULL
);
