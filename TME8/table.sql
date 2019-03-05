create table Employe(
numSS number(5) primary key,
nomE varchar2(20),
prenomE varchar2(20),
villeE varchar2(20),
dateNaissance date,
datecour date default sysdate,
constraint format_numss check (length(numss)=5),
constraint villle_emp check(lower(villeE) in ('paris', 'lyon','marseille')),
constraint limite_age check((datecour-datenaissance)/365<=70)
);

create table Projet(
numproj number,
nomproj varchar2(20),
respproj number(5),
villep varchar2(20),
budget number(6),
constraint pkproj primary key(numproj),
constraint uniq_nomproj unique(nomproj),
constraint format_num check(numproj between 10000 and 9999999),
constraint ville_proj check(lower(villeP) in ('paris','lyon','marseille')),
constraint fk_resp foreign key (respproj) references employe(numSS)
);

create table grille_sal(
profil varchar2(20) primary key,
salaire number(7,2),
constraint sal_max check(salaire<=90000)
);

create table Embauche(
numss number(5),
numproj number ,
dateemb date default sysdate,
profil varchar2(20) ,
constraint pk_emb primary key(numss,numproj),
constraint fk_numss foreign key (numss) references employe(numss),
constraint fk_numproj foreign key (numproj) references projet(numproj),
constraint fk_profil foreign key (profil) references grille_sal(profil)
); 

insert into Employe values(55455, 'Derbane', 'Mohammed', 'paris', to_date('05-01-1998'),sysdate);

insert into Employe values(17271, 'Thoirey', 'Romane','paris', to_date('17-10-1998'),to_date('28-03-2018'));

insert into Employe values(30498, 'Taoussi', 'Doudou', 'marseille', to_date('03-04-1998'),sysdate);

insert into Projet values(140218, 'MomoetRomie','55555','paris',000000);

insert into Projet values(140299,'RomieetMomo','17171','Lyon',000000);

insert into Embauche values(55555,140218,sysdate,'Responsablederomie');

insert into grille_sal values('Responsablederomie',90000);

