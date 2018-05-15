require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  all_characters = RestClient.get('http://www.swapi.co/api/people/') #make the web request
  character_hash = JSON.parse(all_characters)
  character_hash["results"].each do |character_h|
    if character_h["name"] == character
      return character_h["films"].collect do |urls|

        movies = RestClient.get urls
        movies_hash = JSON.parse(movies)
        movies_hash
      end
    end
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |movies,i|
    puts "#{i+1}. #{movies["title"]}"
  end

end

def x(film)
  films_hash.collect do |urls|
    movies = RestClient.get urls
    movies_hash = JSON.parse(movies)
    movies_hash
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# Pry.start

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
