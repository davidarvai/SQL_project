show databases;
use new_project;
Alter table movies modify User_Id INT;
Alter table movie_user modify User_Review Decimal;
describe  movies;
ALTER Table movies add constraint foreign key(User_Id) REFERENCES Movie_User(User_Id);
ALTER Table cast add constraint foreign key(Movie_Id) REFERENCES Movies(Movie_Id);
ALTER Table cast add constraint foreign key(Actor_Id) REFERENCES  Actor(Actor_Id);
describe  cast;
ALTER Table movie_company add constraint foreign key(Movie_Id) REFERENCES Movies(Movie_Id);
ALTER Table movie_company add constraint foreign key(Company_id) REFERENCES  production_company(Company_id);
describe  movie_company;
ALTER Table movie_language add constraint foreign key(Movie_Id) REFERENCES Movies(Movie_Id);
ALTER Table movie_language add constraint foreign key(Language_Id) REFERENCES  language(Language_Id);
describe  movie_language;
ALTER Table movie_director add constraint foreign key(Movie_Id) REFERENCES Movies(Movie_Id);
ALTER Table movie_director add constraint foreign key(Director_Id) REFERENCES  director(Director_Id);
describe  movie_director;
ALTER Table movie_categories add constraint foreign key(Movie_Id) REFERENCES Movies(Movie_Id);
ALTER Table movie_categories add constraint foreign key(Categories_Id) REFERENCES  categories(Categories_Id);
describe  movie_categories;

##Megnovelem a film erteket 1.5 el
SELECT movie_id,title,review,ROUND(review+1.5) increase
FROM movies;

##Kiirja az adott dijal rendelkezo rendezok filmjeit 

Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Director.Director_Last_Name,Director.Director_Frist_Name,Director.Awards
From Director
join Movie_Director
on Movie_Director.Director_Id = Director.Director_Id
join movies
on movies.movie_id = Movie_Director.Movie_Id
Where Director.Awards = 'Saturn Award';

##Az adott bugetel rendelkezo filmeket

SELECT title,movies.review,movies.buget
FROM movies
where movies.buget ='90 million';


##A film keresese rendezo alapjan

Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Director.Director_Last_Name,Director.Director_Frist_Name,Director.Awards
From Director
join Movie_Director
on Movie_Director.Director_Id = Director.Director_Id
join movies
on movies.movie_id = Movie_Director.Movie_Id
WHERE Director_Frist_Name = 'Nolan';



##2008 tol ujabb filmek kiirasa az ertekelesel

SELECT title, review,Publication_year
FROM movies
WHERE Publication_year > '2008'
ORDER BY Publication_year DESC;

#A legidosebb szinesz
Select Name,Max(Age)
From Actor; 

#Szinesz neve alapjan film kereses
Select  movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,actor.name,actor.age,actor.character_name
From actor
join cast
on cast.actor_id = actor.actor_id
join movies
on movies.movie_id = cast.movie_id
where actor.name ='Robert John Downey';

#Szineszek felsorolva
Select Name,age
From actor
Order by age desc;


#9 nagyobb filmek ertekelese
Select Title,publication_year,distributes,review
From movies
Where review > 9;


#3 nal kisebben ertekelt filmek
Select Title,publication_year,distributes,review
From movies
Where review < 3;

#Milyen filmhez milyen szinesz tartozik
Select  a.actor_id,a.movie_id, b.movie_id, b.Title
From cast a join movies b
on a.Movie_Id = b.Movie_Id;


#Kilistaza a filmeket es a szereplo szineszek adatait
Select  movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,actor.name,actor.age,actor.character_name
From actor
join cast
on cast.actor_id = actor.actor_id
join movies
on movies.movie_id = cast.movie_id;




#Kilistaza a filmeket es a keszito ceg adatait
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Production_company.Company_Name
From Production_company
join Movie_company
on Movie_company.Company_id = Production_company.Company_id
join movies
on movies.movie_id = Movie_company.movie_id;


#Kilistaza a filmeket es a nyelveket amin megtekintheto
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Language.Language_Name,Language.Language_Code
From Language
join Movie_Language
on Movie_Language.Language_Id = Language.Language_Id
join movies
on movies.movie_id = Movie_Language.Movie_Id;


#Kilistaza a filmeket es az orszagot ahol keszult
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Country.Country_Name,Country.Country_Code
From Country
join Production_Country
on Production_Country.Country_Id = Country.Country_Id
join movies
on movies.movie_id = Production_Country.Movie_Id;


#Kilistaza a filmeket es a rendzot es a rendezo adatait
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Director.Director_Last_Name,Director.Director_Frist_Name,Director.Awards
From Director
join Movie_Director
on Movie_Director.Director_Id = Director.Director_Id
join movies
on movies.movie_id = Movie_Director.Movie_Id;

#Kilistaza a filmeket es a kategoriakat
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Categories.Categories_Name
From Categories
join Movie_Categories
on Movie_Categories.Categories_Id = Categories.Categories_Id
join movies
on movies.movie_id = Movie_Categories.Movie_Id;

#kilistaz egy adott filmet es meg adja a foszereplot 
Select  movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,actor.name,actor.age,actor.character_name
From actor
join cast
on cast.actor_id = actor.actor_id
join movies
on movies.movie_id = cast.movie_id
Order by review desc;
#Fetch first row only;


#Legregebbi filmet
Select Title as "Legregebbi_Film",max(Publication_year) as "Megjelenesi Ido"
From movies group by Title
Order by max(Publication_year) asc;
#Fetch first row only;



#A legujabb filmet irja ki
Select Title as "Legujabb_Film",max(Publication_year) as "Megjelenesi Ido"
From movies group by Title
Order by max(Publication_year) desc;
#Fetch first row only;



#Kategoria szerint keresunk filmet
Select movies.Title,movies.runtime,movies.publication_year,movies.distributes,movies.review,Categories.Categories_Name
From Categories
join Movie_Categories
on Movie_Categories.Categories_Id = Categories.Categories_Id
join movies
on movies.movie_id = Movie_Categories.Movie_Id
where Categories_Name = 'Action' 
Order by review desc;
 
