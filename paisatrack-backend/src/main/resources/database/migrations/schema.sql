-- =============================================================================
-- PaisaTrack — Schema DDL (run once on empty PostgreSQL database)
-- Only tables backed by current JPA entities in the codebase
-- =============================================================================

-- -----------------------------------------------------------------------------
--          Reset
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS currencies CASCADE;
DROP TABLE IF EXISTS users CASCADE;


--------------------------------------------------------
-- USERS
--------------------------------------------------------

CREATE TABLE users
(
    id         BIGSERIAL    NOT NULL,
    full_name  VARCHAR(255),
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(255),
    role       VARCHAR(20)  NOT NULL DEFAULT 'USER',

    is_active  BOOLEAN      NOT NULL DEFAULT TRUE,
    is_deleted BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at timestamp(6),
    updated_at timestamp(6),
    deleted_at timestamp(6),
    created_by BIGINT,
    updated_by BIGINT,
    deleted_by BIGINT,

    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT chk_users_role CHECK (role IN ('USER', 'ADMIN'))
);

CREATE UNIQUE INDEX uq_users_email_active ON users (email) WHERE is_deleted = FALSE;


--------------------------------------------------------
-- CURRENCIES
--------------------------------------------------------

CREATE TABLE currencies
(
    id              BIGSERIAL  NOT NULL,
    country_name    VARCHAR(255),
    currency_name   VARCHAR(255),
    alphabetic_code VARCHAR(3) NOT NULL,
    symbol          VARCHAR(255),

    is_active       BOOLEAN    NOT NULL DEFAULT TRUE,
    is_deleted      BOOLEAN    NOT NULL DEFAULT FALSE,
    created_at      timestamp(6),
    updated_at      timestamp(6),
    deleted_at      timestamp(6),
    created_by      BIGINT,
    updated_by      BIGINT,
    deleted_by      BIGINT,

    CONSTRAINT pk_currencies PRIMARY KEY (id),
    CONSTRAINT uq_currencies_alphabetic_code UNIQUE (alphabetic_code)
);


--------------------------------------------------------
-- CATEGORIES
--------------------------------------------------------

CREATE TABLE categories
(
    id            BIGSERIAL   NOT NULL,
    category_name VARCHAR(255),
    category_type VARCHAR(10) NOT NULL,

    is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
    is_deleted    BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at    timestamp(6),
    updated_at    timestamp(6),
    deleted_at    timestamp(6),
    created_by    BIGINT,
    updated_by    BIGINT,
    deleted_by    BIGINT,

    CONSTRAINT pk_categories PRIMARY KEY (id),
    CONSTRAINT chk_categories_type CHECK (category_type IN ('CASH_IN', 'CASH_OUT')),
    CONSTRAINT uq_categories_name_type UNIQUE (category_name, category_type)
);


--------------------------------------------------------
-- BOOKS
--------------------------------------------------------

CREATE TABLE books
(
    id          BIGSERIAL NOT NULL,
    book_name   VARCHAR(255),
    user_id     BIGINT    NOT NULL,
    currency_id BIGINT    NOT NULL,

    is_active   BOOLEAN   NOT NULL DEFAULT TRUE,
    is_deleted  BOOLEAN   NOT NULL DEFAULT FALSE,
    created_at  timestamp(6),
    updated_at  timestamp(6),
    deleted_at  timestamp(6),
    created_by  BIGINT,
    updated_by  BIGINT,
    deleted_by  BIGINT,

    CONSTRAINT pk_books PRIMARY KEY (id),
    CONSTRAINT fk_books_users
        FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_books_currencies
        FOREIGN KEY (currency_id) REFERENCES currencies (id)
);

CREATE INDEX idx_books_user_id ON books (user_id);


--------------------------------------------------------
-- TRANSACTIONS
--------------------------------------------------------

CREATE TABLE transactions
(
    id               BIGSERIAL      NOT NULL,
    amount           NUMERIC(15, 2) NOT NULL,
    transaction_date DATE,
    note             VARCHAR(255),
    book_id          BIGINT         NOT NULL,
    category_id      BIGINT         NOT NULL,

    is_active        BOOLEAN        NOT NULL DEFAULT TRUE,
    is_deleted       BOOLEAN        NOT NULL DEFAULT FALSE,
    created_at       timestamp(6),
    updated_at       timestamp(6),
    deleted_at       timestamp(6),
    created_by       BIGINT,
    updated_by       BIGINT,
    deleted_by       BIGINT,

    CONSTRAINT pk_transactions PRIMARY KEY (id),
    CONSTRAINT chk_transactions_amount CHECK (amount > 0),

    CONSTRAINT fk_transactions_books
        FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE,
    CONSTRAINT fk_transactions_categories
        FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE INDEX idx_transactions_book_date ON transactions (book_id, transaction_date);
CREATE INDEX idx_transactions_category_id ON transactions (category_id);