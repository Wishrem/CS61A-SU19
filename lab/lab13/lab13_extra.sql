.read lab13.sql

CREATE TABLE su19favpets AS
  SELECT pet, COUNT(*) as count
  FROM students
  GROUP BY pet
  ORDER BY count DESC, pet
  LIMIT 10;


CREATE TABLE su19dog AS
  SELECT pet, COUNT(*)
  FROM students
  WHERE pet = 'dog';


CREATE TABLE obedienceimages AS
  SELECT seven, instructor, COUNT(*)
  FROM students
  WHERE seven = '7'
  GROUP BY instructor;
