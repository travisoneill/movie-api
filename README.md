##API ENDPOINTS##

#####/movies/:id(/:relation)#####

returns individual movie object if no relation param
```
GET /movies/1
```
#####RELATION#####
options:

-related (0 points for creativity)

if optional relation param is provided returns collection of the related
movies to the id provided

TODO: Should give the user option to add query string here

```
GET /movies/1/related
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

sort_order={order}

options

-[ascending, asc, a]

-[descending, desc, d]

default: desc

```
GET /movies?year=1988-2000&sort=tile&sort_order=desc
```
