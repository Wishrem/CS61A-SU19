CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size
  FROM dogs, sizes
  WHERE height <= max AND height > min;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child_dog.name AS name
  FROM dogs as child_dog, parents, dogs as parent_dog
  WHERE child = child_dog.name AND parent_dog.name = parent
  ORDER BY parent_dog.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.name AS dog1, b.name AS dog2
  FROM dogs AS a, dogs AS b, parents AS ap, parents AS bp
  WHERE a.name < b.name AND ap.child = a.name AND bp.child = b.name AND ap.parent = bp.parent
  ORDER BY a.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT PRINTF("%s and %s are %s siblings", dog1, dog2, size1.size)
  FROM siblings, size_of_dogs AS size1, size_of_dogs AS size2
  WHERE dog1 = size1.name AND dog2 = size2.name AND size1.size = size2.size;

-- Total size for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, SUM(height)
  FROM dogs
  GROUP BY fur
  HAVING height >= AVG(height) * 0.7 AND height <= AVG(height) * 1.3;