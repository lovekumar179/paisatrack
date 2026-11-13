CREATE
EXTENSION IF NOT EXISTS pgcrypto;

BEGIN;


--------------------------------
-- Admin user
--------------------------------

INSERT INTO users (id, full_name, email, password, role,
                    is_active, is_deleted, created_at, updated_at, created_by, updated_by)
VALUES (1,
        'Admin',
        'admin@paisatrack.app.com',
        'admin@58',
        'ADMIN',
        TRUE, FALSE, NOW(), NOW(), NULL, NULL) ON CONFLICT DO NOTHING;

UPDATE users
SET created_by = 1,
    updated_by = 1
WHERE id = 1;


--------------------------------
-- Categories
--------------------------------

INSERT INTO categories (category_name, category_type, created_at, updated_at)
VALUES
    -- CASH IN
    ('Salary', 'CASH_IN', NOW(), NOW()),
    ('Business', 'CASH_IN', NOW(), NOW()),
    ('Investment', 'CASH_IN', NOW(), NOW()),
    ('Rent', 'CASH_IN', NOW(), NOW()),
    ('Loan', 'CASH_IN', NOW(), NOW()),
    ('Other', 'CASH_IN', NOW(), NOW()),

    -- CASH OUT
    ('Groceries', 'CASH_OUT', NOW(), NOW()),
    ('Food', 'CASH_OUT', NOW(), NOW()),
    ('Taxi / Car / Bike', 'CASH_OUT', NOW(), NOW()),
    ('Shopping', 'CASH_OUT', NOW(), NOW()),
    ('Entertainment', 'CASH_OUT', NOW(), NOW()),
    ('Gas / Electricity / Bills', 'CASH_OUT', NOW(), NOW()),
    ('Mobile & Internet', 'CASH_OUT', NOW(), NOW()),
    ('Health', 'CASH_OUT', NOW(), NOW()),
    ('Education', 'CASH_OUT', NOW(), NOW()),
    ('Rent', 'CASH_OUT', NOW(), NOW()),
    ('Loan Repayment', 'CASH_OUT', NOW(), NOW()),
    ('Zakat & Charity', 'CASH_OUT', NOW(), NOW()),
    ('Other', 'CASH_OUT', NOW(), NOW()) ON CONFLICT (category_name, category_type) DO NOTHING;

SELECT setval(pg_get_serial_sequence('users', 'id'), GREATEST((SELECT MAX(id) FROM users), 1));

COMMIT;