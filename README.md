# crystal-kemal-postgre-sample

Sample code in Crystal using Kemal web framework connected to PostgreSQL 

## Installation

Create a PostgreSQL database with the following table and populate it with some data.

```sql
CREATE TABLE people (
  id serial PRIMARY KEY,
  first VARCHAR(20) NOT NULL,
  last VARCHAR(20) NOT NULL
);
```

Modify the PostgreSQL DB configuration in main.yml 

## Usage

crystal src/crystal-kemal-postgre-sample.cr 

## Development

## Contributing

(This is just some sample code, but leaving the original instructions below)

1. Fork it (<https://github.com/your-github-user/my-postgresql/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Shunichi Kanade](https://github.com/skanade) - creator and maintainer
