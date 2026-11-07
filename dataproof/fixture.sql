-- A synthetic dataset for the template's schema at cc480df7 (revision 9c0a54914c78): five users
-- and eight items. No real people; the password hashes are placeholders, not hashes.
-- Owners are deliberately not item k -> user k, so a migration that joins on the wrong column
-- moves items to the wrong owners instead of passing by coincidence.
INSERT INTO "user" (id, email, is_active, is_superuser, full_name, hashed_password) VALUES
    (1, 'admin@example.com', true, true, 'Avery Stone', 'fixture-placeholder-01'),
    (2, 'blake@example.com', true, false, 'Blake Rivera', 'fixture-placeholder-02'),
    (3, 'casey@example.org', true, false, 'Casey Ngô', 'fixture-placeholder-03'),
    (4, 'devon@example.net', false, false, NULL, 'fixture-placeholder-04'),
    (5, 'emery@example.com', true, false, 'Emery O''Neill', 'fixture-placeholder-05');

INSERT INTO item (id, title, description, owner_id) VALUES
    (1, 'Quarterly report', 'Draft for the October review', 3),
    (2, 'Grocery list', NULL, 1),
    (3, 'Café notes', 'Ünïcödé survives a migration', 2),
    (4, 'Garage inventory', 'Bikes, tools, two tents', 2),
    (5, 'Reading list', NULL, 4),
    (6, 'Trip itinerary', 'Flights on the 3rd, back on the 9th', 1),
    (7, 'Recipe: lentil soup', 'Avery''s version, with cumin', 3),
    (8, 'Bug triage', 'Every open issue older than a week', 2);
