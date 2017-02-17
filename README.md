##QUICK START##
```bash
# Initial Setup: (skip if rails and bundler gems installed on your machine) requires Ruby
$ gem install rails
$ gem install bundler
```
Run the API locally:
```bash
# Clone the repo and run the app:
$ git clone https://github.com/travisoneill/movie-api.git
$ cd movie-api
# Install dependencies
$ bundle install
# Setup database
$ rake db:create
$ rake db:migrate
$ rake db:seed
# Run the server
$ bundle exec rails s
```

##API ENDPOINTS##

Include the following headers in all requests:
'Content-Type': 'application/vnd.api+json'
'Accept': 'application/vnd.api+json'

#####/movies/:id(/:relation)#####

returns individual movie object if no relation param
```
GET /movies/1
```
#####RELATION#####
options:

-related_movies (0 points for creativity)

if optional relation param is provided returns collection of the related
movies to the id provided

TODO: Should give the user option to add query string here

```
GET /movies/1/related_movies
```

#####/movies?{query}#####

if no query returns collection of all movies
```
GET /movies
```

###QUERIES###

#####TITLE#####

title={title} (case insensitive)
```
GET /movies?title=the%20godfather
```

#####YEAR#####

year={exact year}

```
GET /movies?year=1988
```
year={{start_year}-{end_year}}
```
GET /movies?year=1988-2000
```

#####SORTING RESULTS#####

sort={attr}

options:

-title

-year

-id

default: id
```
GET /movies?year=1988-2000&sort=title
```

Sort order is ascending by default.  To sort descending put a '-' in front
of the sort attribute.

```
GET /movies?year=1988-2000&sort=-title
```

###RATINGS###

```
POST /movie_ratings
```

```
PATCH /movie_ratings
```

Send a MovieRating resource object as request data to create or update a user rating
format:

```json
{
  "data": {
    "type": "movie_rating",
    "attributes": {
      "movie_id": 9,
      "user_id": 2,
      "rating": 4
    }
  }
}
```
