# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MOVIES = [
  {
    "title": "A Wonderful Film",
    "description": "A cute film about lots of wonderful stuff.",
    "year": 1973,
    "related_film_ids": [2, 4, 7]
  },
  {
    "title": "All About Fandor",
    "description": "Documentary telling the tail of Fandor.",
    "year": 2001,
    "related_film_ids": [1, 4, 7]
  },
  {
    "title": "Dancing with Elephants",
    "description": "The classic tale of Dancing with Wolves, but with elephants!",
    "year": 2016,
    "related_film_ids": []
  },
  {
    "title": "The Story of George",
    "description": "A true story outlining the adventures of George",
    "year": 1974,
    "related_film_ids": [1, 2, 7]
  },
  {
    "title": "Zee and Bee Go Skiiing",
    "description": "The tragic story of Zee and Bee on their snowy adventures.",
    "year": 1991,
    "related_film_ids": [6, 8, 9, 10]
  },
  {
    "title": "Ahead of Its Time",
    "description": "A story about the future.",
    "year": 2088,
    "related_film_ids": [8, 9, 10]
  },
  {
    "title": "My Name is Jerry",
    "description": "The life of the cat named Jerry.",
    "year": 1989,
    "related_film_ids": [1, 2, 4]
  },
  {
    "title": "Gems and Trestle",
    "description": "Is it about web development? Mining history? You'll never know.",
    "year": 2011,
    "related_film_ids": [9, 10]
  },
  {
    "title": "How To React Natively",
    "description": "A step by step journey through developing a React Native application.",
    "year": 2000,
    "related_film_ids": [10]
  },
  {
    "title": "Perry Hotter: A Lizard's Tale",
    "description": "It's a story all about a lizard named Perry.",
    "year": 2017,
    "related_film_ids": []
  }
]

MOVIES.each do |movie|
  related = movie[:related_film_ids].dup
  movie.delete(:related_film_ids)
  mov = Movie.create!(movie)
  related.each do |rel|
    MovieRelationship.create({ movie_id1: mov.id, movie_id2: rel })
  end
end
