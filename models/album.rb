require_relative('../db/sqlrunner')
require_relative('artist')

class Album

  attr_accessor :title, :genre

  def initialize(options_hash)
    @title = options_hash['title']
    @genre = options_hash['genre']
    @artist_id = options_hash['artist_id'].to_i()
  end




  def Album.all()
    sql = "SELECT * FROM albums;"
    albums_hashes = SqlRunner.run(sql)
    albums = albums_hashes.map do |hash|
      Album.new(hash)
    end
    return albums
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values)[0]
    artist = Artist.new(artist_hash)
    return artist
  end





#     sql ="SELECT id, title, genre, artist_id FROM albums WHERE title LIKE $1"
# query = "%" + query + "%"
# values = [query]
# SqlRunner.run(sql, [query])

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def Album.delete_by_id(id)
    sql = "DELETE FROM albums WHERE id=$1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def Album.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id=$1;"
    values = [id]
    album_hash = SqlRunner.run(sql, values)[0]
    album = Album.new(album_hash)
    return album
  end

  # you could make these private and call a if @id to check if save
  def save()
    sql = "
    INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3) RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

end
