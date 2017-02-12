# Statistics

This is a web app to CRUD and query data of properties/real estates.

The entry point for the CRUD is [`localhost:4000/properties`](http://localhost:4000/properties).

The following queries can be accessed via API
  * [`localhost:4000/query/averageRentInRanges`](http://localhost:4000/query/averageRentInRanges) returns the average rent of properties in ranges covering 5 squareMetres
  * [`localhost:4000/query/averageRent?minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80`](http://localhost:4000/query/averageRent?minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80) returns the average rent of properties with a size between minSquareMetresExclusive and maxSquareMetresInclusive
  * [`localhost:4000/query/cheapestInRanges`](http://localhost:4000/query/cheapestInRanges) returns the cheapest properties in ranges covering 5 squareMetres
  * [`localhost:4000/query/cheapest?maxCount=3&minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80`](http://localhost:4000/query/cheapest?maxCount=3&minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80) returns at most maxCount of the cheapest properties with a size between minSquareMetresExclusive and maxSquareMetresInclusive
  * [`localhost:4000/query/priciest?maxCount=3&minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80`](http://localhost:4000/query/priciest?maxCount=3&minSquareMetresExclusive=60.5&maxSquareMetresInclusive=80) returns at most maxCount of the priciest properties with a size between minSquareMetresExclusive and maxSquareMetresInclusive
  * [`localhost:4000/query/rentPerSquareMetre?maxCount=3`](http://localhost:4000/query/rentPerSquareMetre?maxCount=3) returns at most maxCount of the properties with the best rent per square metre

## To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
