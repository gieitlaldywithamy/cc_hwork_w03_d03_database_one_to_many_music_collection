require('pg')

class SqlRunner

  def self.run(sql, values=[])
    begin
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare("run", sql)
      result = db.exec_prepared("run", values)
    rescue PG::ConnectionBad
      p "dealing with PG:ConnectionBad"
      # rescue PG:ConnectionBad => error
      # raise
    ensure
      db.close() if db != nil
    end
    return result
  end

end
