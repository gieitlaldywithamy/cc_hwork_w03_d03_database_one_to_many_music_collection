require_relative('../db/sqlrunner.rb')

class Artist

  attr_reader :id

  def initialize( options_hash )
    @first_name = options_hash['first_name']
    @last_name = options_hash['last_name']
    @id = options_hash['id'].to_i if options_hash['id']
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
end
