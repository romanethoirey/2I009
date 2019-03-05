select s.nomsp, count(*) as nbmedailles
from Sport s, RangIndividuel r, Athlete a, Epreuve e
where s.sid=e.sid and r.aid=a.aid and r.epid=e.epid and r.rang<=3
group by s.sid, s.nomsp
order by nbmedailles desc; 

select s.nomsp, p.nomp,count(*) as nbmedailles
from Sport s, RangIndividuel r, Athlete a, Epreuve e, Pays p
where s.sid=e.sid and r.aid=a.aid and r.epid=e.epid and r.rang<=3 and p.codepays=a.codepays
group by s.sid, s.nomsp,p.codepays,p.nomp 
order by nbmedailles desc; 


select s.nsp,count(distinct e.neq) as nbequipe
from Sponsorise s, Joueur j, EquipeF e
where s.njo=j.nJO and e.neq=j.eq 
group by s.nsp
having count(distinct e.neq)=(select count(*) from Equipef);

select s.nsp, count(distinct e.neq)
from Sponsorise s, Joueur j, Equipef e
where s.njo=j.nJO and e.neq=j.eq
group by s.nsp
having  count(distinct e.neq)=count(j.njo);

select m1.eq1, sum(d.nbkm)
from Equipef e, Match m1, Match m2, dist d
where e.neq=m1.eq1 and e.neq=m2.eq1 and m1.st=d.st1 and m2.st=d.st2
and m1.datem < m2.datem
and not exists
(select *
from Match m3
where m3.datem <m2.datem and m3.datem >m1.datem)
group by e.neq ;
