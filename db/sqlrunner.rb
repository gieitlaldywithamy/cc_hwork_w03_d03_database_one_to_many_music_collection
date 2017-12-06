require('pg')

class SqlRunner

  def self.run(sql, values=[])
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    db.prepare("run", sql)
    result = db.exec_prepared("run", values)
    db.close()
    return result
  end

end
