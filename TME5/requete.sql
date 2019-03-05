select distinct s.nomsp, e.nomep,e.categorie
from Sport s, Epreuve e, RangIndividuel r
where r.epid=e.epid and s.sid=e.sid;

select distinct a.nomath, a.prenomath, r.rang, p.nomp
from Athlete a, Pays p, RangIndividuel r, Epreuve ep, Sport s
where s.nomsp='Patinage de vitesse'
and ep.nomep='1000m'
and ep.categorie='Femmes'
and ep.epid=r.epid
and a.aid=r.aid
and s.sid=ep.sid
and p.codepays=a.codepays ;

select distinct a.nomath, a.prenomath
from Athlete a, RangEquipe r, Equipe eq, Epreuve ep, Sport s, AthletesEquipe ae
where s.nomsp='Biathlon'
and ep.nomep='relais 4x6km'
and ep.categorie='Femmes'
and r.rang=1
and s.sid=ep.sid
and ep.epid=r.epid
and eq.eqid=r.eqid
and eq.eqid=ae.eqid
and a.aid=ae.aid;

select distinct s.nomsp
from Athlete a, Sport s, Epreuve ep, RangIndividuel r
where a.prenomath='Erik'
and a.nomath='LESSER'
and s.sid=ep.sid
and r.epid=ep.epid
and r.aid=a.aid;

select distinct a.nomath, a.prenomath
from Sport s1, Athlete a, Epreuve ep1, RangIndividuel r1 
where
s1.sid=ep1.sid
and r1.epid=ep1.epid
and r1.aid=a.aid
and exists
(select *
from Sport s2, Epreuve ep2, RangIndividuel r2 
where s1.sid<>s2.sid
and s2.sid=ep2.sid
and r2.epid=ep2.epid
and r2.aid=a.aid);


select distinct ep1.datedebut, ep2.datefin
from Epreuve ep1, Epreuve ep2
where not exists
(select *
from Epreuve ep3
where ep3.datedebut<ep1.datedebut)
and not exists
(select *
from Epreuve ep4
where ep4.datefin>ep2.datefin);

select distinct p.codepays, p.nomp
from Athlete a, Pays p
where (2016-extract(year from a.datenaissance))>40
and a.codepays=p.codepays;
/*il manque autriche mais tant pis on a pas les mineurs*/

select distinct eq1.eqid, eq1.codepays
from Equipe eq1, AthleteEquipe ae
where not exists
(select *
from Equipe eq2
where );
/*il etait 12h23 on a faim du coup on a pas fini c'est triste mais tant pis tu finiras ca un autre jour*/
/*d'ailleurs tu finiras ca surement ajd si tu as reouvert ce fichier*/
