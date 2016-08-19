require 'sqlite3'

database = SQLite3::Database.new("db/robot_world_development.db")

database.execute("DELETE FROM robots")

database.execute("INSERT INTO robots (name, city, state, birthday, date_hired, department) VALUES ('Tommy', 'Las Vegas', 'NV', '1979-05-06', '2016-08-01', 'BioMetrics'), ('Samantha', 'Detroit', 'MI', '1992-07-15', '2016-08-09', 'Physics'), ('Ralph', 'Tuscon', 'AZ', '1999-09-01', '2016-08-17', 'Home Science'), ('Jack', 'East Thetford', 'VT', '2016-08-16', '2016-08-04', 'Garage Doors'), ('Alice', 'Buffalo', 'NY', '2014-01-01', '2016-08-04', 'Bathroom Sanitation'), ('Annabelle', 'Wilmington', 'DE', '2016-08-02', '2016-08-03', 'Physics'), ('Sarah', 'Radford', 'VA', '1990-06-05', '2016-08-02', 'Bathroom Sanitation');")

puts "It worked and:"
p database.execute("SELECT * FROM robots;")
