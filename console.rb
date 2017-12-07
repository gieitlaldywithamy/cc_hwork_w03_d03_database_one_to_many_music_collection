require('pg')
require('pry-byebug')

require_relative('models/artist.rb')
require_relative('models/album')


artist1 = Artist.new({'first_name'=>'Snoop', 'last_name' => 'Dogg'})
artist2 = Artist.new({'first_name'=>'Douglas', 'last_name' => 'Santor'})

artist1.save()
artist2.save()


album1 = Album.new({
  'title' => 'Snoopy1',
  'genre' => 'rap',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'My teenage diary',
  'genre' => 'country',
  'artist_id' => artist2.id
  })

album3 = Album.new({
  'title' => 'Doggy Treats',
  'genre' => 'thrash metal',
  'artist_id' => artist1.id
  })



album1.save()
album2.save()
album3.save()

artist1.last_name = "Doggy Dogg"
artist1.update()

album1.genre = "happy hardcore"
album1.update()
artists = Artist.all()
albums = Album.all()
# Artist.delete_by_id(11)
Album.delete_by_id(17)
Artist.delete_by_id(12)
# Album.delete_all()
# Artist.delete_all()
p Album.find_by_id(18)
p Artist.find_by_id(25)

binding.pry
nil
