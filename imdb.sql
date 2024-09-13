create database imdb
use imdb

create table Directors(
id int primary key identity,
[name] nvarchar(225)
)
create table actors(
id int primary key identity,
[name] nvarchar(225)
)

create table movies(
id int primary key identity,
[name] nvarchar(225),
relaseYear int,
directorId int foreign key references directors(id)
)
alter table movies add imdbRating decimal(3,1)
create table genres(
id int primary key identity,
[name] nvarchar(225)
)

create table MoviesGenres(
movieId int,
genreId int,
foreign key (movieId) references movies(id),
foreign key (genreId) references genres(id)
)
create table moviesActors(
moviesId int,
actorsId int,
primary key(moviesId,actorsId),
foreign key (moviesId) references movies(id),
foreign key (actorsId) references actors(id)
)
INSERT INTO Directors (name) VALUES
('Christopher Nolan'),
('Quentin Tarantino'),
('Steven Spielberg');
INSERT INTO Actors (name) VALUES
('Leonardo DiCaprio'),
('Brad Pitt'),
('Tom Hanks');
INSERT INTO Genres (name) VALUES
('Action'),
('Drama'),
('Thriller');
INSERT INTO Movies VALUES
('Inception', 2010, 1),
('Pulp Fiction', 1994, 2), 
('Saving Private Ryan', 1998, 3); 
INSERT INTO MoviesGenres VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 2);
INSERT INTO movies  VALUES
('Jurassic Park', 1993, 8.1, 1),
('Inception', 2010, 8.8, 2),
('Pulp Fiction', 1994, 8.9, 3),
('The Wolf of Wall Street', 2013, 8.2, 4),
('Avatar', 2009, 7.8, 5);
select m.name,m.imdbRating,g.name from movies m
join MoviesGenres mg on mg.movieId=m.id
join genres g on mg.genreId=g.id
WHERE 
g.name LIKE '%a%';
select m.name,m.imdbRating,m.relaseYear,g.name from movies m
join MoviesGenres mg on mg.genreId=m.id
join genres g on mg.genreId=g.id
where Len(m.name)>10 and m.name like '%n'
select m.id,m.name,m.imdbRating,d.name directorName,a.name actorName from movies m 
join MoviesGenres mg on mg.movieId=m.id
join genres g on mg.genreId=g.id
join Directors d on m.directorId=d.id
join moviesActors ma on ma.moviesId=m.id
join actors a on ma.actorsId=a.id
where m.imdbRating>(select avg(m.imdbRating) from movies m) 
order by m.imdbRating desc