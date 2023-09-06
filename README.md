# Decidim::Connector

This module serves as a simple local database storage for API data when loading
data from external APIs to Decidim. For instance, if you want to load news
articles, events, etc. from external APIs and show then in Decidim, you can
utilize this module to store the data locally.

API data many times needs to be stored locally to improve the performance of the
website as well as to prevent any errors in case the API has some connectivity
issues. The data can be fetched directly from the database connected with the
instance as with any other records.

So why not just use the default Rails caching layer? Mileage may vary but the
caching layer comes with its pitfalls for this type of needs as it may not work
across all Rails environments in a similar manner and it can also run into its
limits if there is a lot of data. If the caching is done at the rendering layer
(i.e. controllers or views), it may cause problems if not done properly. And
handling all that "properly" would require extra code, i.e. this module (i.e.
synchronizing the data separately from displaying it).

## Usage

This is a backend development module aimed for developers. There is no user
interface or other functionality provided by this module.

The workflow for a new data integration is the follows:

1. Create a new connector set (e.g. `events`), this is what holds your data.
2. Create a rake task or periodic background job to load the data from the API.
3. Add the API data as `Item`s connected to the created set.
4. When displaying this data on the website or utilizing it in some other
   context, load it from the local database instead of the API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-connector", github: "mainio/decidim", branch: "main"
```

And then execute:

```bash
bundle
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
