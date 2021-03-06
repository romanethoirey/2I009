select s.nomsp
from Sport s
where 0=all(select e1.datefin-e1.datedebut from Epreuve e1 where s.sid=e1.sid); 

select distinct s.nomsp
from Sport s
where  not exists (select * from Epreuve e where s.sid=e.sid
and lower(e.categorie)='mixte');


select distinct eq.eqid
from Equipe eq
where not exists (select * from rangindividuel r, AthletesEquipe ae, Athlete a
where a.aid=ae.aid and eq.eqid=ae.eqid and r.aid=a.aid and r.rang <=3);

select a.datenaissance, a.codepays
from Athlete a
where not exists (select * from Athlete a1 where a1.datenaissance>a.datenaissance)
and a.datenaissance is not null;


select distinct a.nomath, a.prenomath
from Pays p, Athlete a
where not exists (select * from Athlete a1 where a1.datenaissance>a.datenaissance and a1.codepays=p.codepays)
and a.datenaissance is not null
and a.codepays=p.codepays;
