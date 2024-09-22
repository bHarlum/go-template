-- Insert a entry into examples table
INSERT INTO examples (name)

-- Delete a entry from examples table
DELETE FROM examples WHERE id = $1

-- Update a entry in examples table
UPDATE examples SET name = $1 WHERE id = $2

-- Select all entries from examples table
SELECT * FROM examples

-- Select a entry from examples table
SELECT * FROM examples WHERE id = $1