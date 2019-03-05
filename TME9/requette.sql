create table Employe(       
			NumSS	number(15)		, /*contrainte D1*/       
			NomE  	varchar2(20) NOT NULL	, /*contrainte D2*/       
			PrenomE	varchar2(20) NOT NULL	, /*contrainte D2*/       
			VilleE	varchar2(20) NOT NULL	, /*contrainte D2*/       
			DateNaiss date 	     NOT NULL	,      
			dateCour  date	     default sysdate,
					/*attribut superflu utile pour exprimer la contrainte C1*/       
			/*contraintes de cle et referentielles*/       
			constraint pk_emp
                		   primary key (NumSS),      
			/*contraintes generales*/       
			constraint limite_age       		  
                		   check ((dateCour-DateNaiss)/365<=70), 
			/*contraintes de domaine*/      
			constraint format_nss  
                		   check(length(NumSS)=5),
			constraint ville_emp      
                		   check (lower(villeE) in ('paris', 'lyon', 'marseille')) 		 
			); 


create  table Projet(      
			NumProj	Number(3),
			NomProj	varchar2(20)	NOT NULL,
			RespProj	number	NOT NULL,       
			VilleP	varchar2(20)	NOT NULL,       
			Budget		number,       
			/*contraintes de clés*/
			constraint pk_proj       		  
				primary key(numproj),       
			constraint fk_resp       		  
				foreign key (RespProj) references Employe,             
			constraint ville_proj       		  
				check (lower(villeP) in ('paris', 'lyon', 'marseille')),       
			constraint limite_budget       		  
				check (budget <1000000) 		  
		); 

create table Grille_sal(       
			profil	varchar2(20),       
			salaire	number(7,2)	NOT NULL,            
			 /*contraintes de clés*/
			constraint pk_sal  
                primary key (profil),
			 /*contraintes de domaine*/
			constraint sal_max 
                check (salaire<90000) 
			); 


create table Embauche(       
			NumSS	number ,
			NumProj	number ,       
			DateEmb	date default sysdate NOT NULL,       
			Profil	varchar2(20) NOT NULL,       
			/*contraintes de clés*/
     			constraint pk_emb primary key (NumSS, NumProj),
			constraint fk_emb_emp 
               			    foreign key (NumSS) references Employe,
			constraint fk_emb_proj 
               			    foreign key (NumProj) references Projet,
			constraint fk_emb_sal 
               			    foreign key (Profil) references Grille_sal	
			);


drop table Employe cascade constraints;
drop table Projet cascade constraints;
drop table Embauche cascade constraints;
drop table Grille_sal cascade constraints;
purge recyclebin;

@TME8-creations


insert into Employe (NumSS, NomE, PrenomE, VilleE, DateNaiss)
select * from (
       select	22334, 'Adam', 'Funk', 'Paris', '1-12-1982'		from dual union all
       select	45566, 'Rachid', 'Allaoui', 'Lyon', '13-4-1986'	     	from dual union all
       select	77889, 'Florent', 'Girac' , 'Marseille', '4-11-1990'	from dual union all
       select 	90011, 'Mayla', 'Aoun', 'Lyon', '26-3-1987'		from dual union all
       select	22233, 'Christine', 'Lara', 'Paris', '9-8-1982'		from dual union all
       select	34445, 'Amel', 'Orlando', 'Lyon', '14-2-1976'		from dual union all
       select	55666, 'Mohsen', 'Charef', 'Paris', '28-5-1991'		from dual union all
       select	77788, 'Tim', 'Arabi', 'Marseille', '8-6-1984'		from dual union all
       select	89990, 'Fernando', 'Lopez', 'Lyon', '5-10-1993'		from dual union all
       select	11122, 'Ada','Tan Lee', 'Marseille', '21-3-1994'	from dual
);


insert into Projet values (123, 'ADOOP', 22334, 'Paris', 120000);
insert into Projet values (757, 'SKALA', 45566, 'Lyon', 180000);
insert into Projet values (890, 'BAJA', 22334, 'Paris', 24000);


insert into grille_sal values ('Admin', 80000);
insert into grille_sal values ('Deve',45000);
insert into grille_sal values ('Tech',35000);

insert into Embauche values (77889, 123, '1-3-2014','Deve');
insert into Embauche values (90011, 123, '1-5-2014','Tech');
insert into Embauche values (22233, 757, '1-3-2014','Deve');


insert into Employe values (11122, 'Sacha','Ka', 'Marseille', '21-3-1994','05-04-2018');

insert into Employe values (12345, 'Ada','Tan Lee', 'Marseille', '21-3-1920','05-04-2018');

insert into Employe values (311122, 'Sacha','Ka', 'Marseille', '21-3-1994',NULL);

insert into Employe values (11122, 'Sacha','Ka', 'Sucy en brie', '21-3-1994','05-04-2018');

insert into Projet values (500,'TIPI',45766,'Paris',50000);

insert into Projet values (500,'TIPI',45766,'Sucy en brie',50000);

insert into Embauche values (45566,123,'1-3-2014','Resp');

delete from Employe where numss not in (select numss from Embauche e union (select respproj from Projet));

delete from Projet where numproj not in (select e.numproj from Embauche e);

delete from Grille_sal where profil not in (select e.profil from Embauche e);

delete from Embauche;

update employe set numss=numss+1 where  numss not in (select numss from Embauche e union (select respproj from Projet));

update projet set numproj=numproj+1 where numproj not in (select e.numproj from Embauche e);

update employe set villeE='Lyon' where numss in (select p.respproj from Projet p);

update grille_sal set profil='moche' where profil not in (select e.profil from Embauche e);

select * from Grille_Sal;
