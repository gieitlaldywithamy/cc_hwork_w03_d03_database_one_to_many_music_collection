require_relative('../db/sqlrunner')

class Album

  def initialize(options_hash)
    @title = options_hash['title']
    @genre = options_hash['genre']
    @artist_id = options_hash['artist_id'].to_i()
  end


  def save()
    sql = "
    INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3) RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


  def Album.all()
    sql = "SELECT * FROM albums;"
    albums_hashes = SqlRunner.run(sql)
    albums = albums_hashes.map do |hash|
      Album.new(hash)
    end
    return albums
  end


end
