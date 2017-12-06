require_relative('../db/sqlrunner.rb')
require_relative('album')

class Artist

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize( options_hash )
    @first_name = options_hash['first_name']
    @last_name = options_hash['last_name']
    @id = options_hash['id'].to_i

  end

  def save()
    sql = "INSERT INTO artists (first_name, last_name) VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i()
  end


  def Artist.all()
    sql = "SELECT * FROM artists;"
    artist_hashes = SqlRunner.run(sql)
    artists = artist_hashes.map { |hash| Artist.new(hash) }
    return artists
  end


  def albums()
    sql = "SELECt * FROM albums WHERE artist_id = $1;"
    albums_hashes = SqlRunner.run(sql, [@id])
    albums = albums_hashes.map do |hash|
      Album.new(hash)
    end
    return albums
  end


  def update()
    sql = "UPDATE artists SET (first_name, last_name)
    = ($1, $2) WHERE id = $3;"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def Artist.delete_by_id(id)
    sql = "DELETE FROM artists WHERE id=$1;"
    values = [id]
    SqlRunner.run(sql, values)
  end



end
