# Database Scripts

- **`schema.sql`** — creates all 12 tables matching [`../docs/erd/IT_Helpdesk_ERD.drawio`](../docs/erd/IT_Helpdesk_ERD.drawio), in dependency order, with primary/foreign keys and indexes. MySQL 8.x syntax.
- **`seed.sql`** — sample data for local development and demos (roles, users, a handful of tickets with comments/attachments/notifications, two knowledge base articles). Run after `schema.sql`, on an empty database.

## Usage (plain MySQL)

```bash
mysql -u root -p -e "CREATE DATABASE it_helpdesk CHARACTER SET utf8mb4;"
mysql -u root -p it_helpdesk < schema.sql
mysql -u root -p it_helpdesk < seed.sql
```

## Usage (Laravel)

If you're building this with Laravel, the cleanest path is to convert these
into migrations rather than running the raw `.sql` directly:

```bash
php artisan make:migration create_roles_table
php artisan make:migration create_categories_table
# ... one per table, in the same dependency order as schema.sql
```

Then port each `CREATE TABLE` block into its migration's `up()` method using
`Schema::create(...)`, and `seed.sql`'s data into a `DatabaseSeeder` (or
`php artisan make:seeder` per table) using Eloquent models or `DB::table()->insert()`.
Keeping `schema.sql` here as the source of truth makes it easy to check your
migrations match the ERD.

Want me to generate the actual Laravel migration + seeder files instead of / in addition to these raw SQL scripts? Just ask.
