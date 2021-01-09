drop database tp;
create database if not exists tp;
use tp;

create table if not exists Proprietaire(
    NomPro varchar(20) primary key,
    adr varchar(50), 
    Num_tel varchar(20) unique,
	Category varchar(20)
);
create table if not exists Pilote(
	IDPil int  primary key auto_increment,
    Nom_brevet int,
    nom varchar(20),
	adr varchar(50),
    Num_tel varchar(20)
);
create table if not exists Mecanicien(
	IDMec int not null primary key auto_increment,
    Nom varchar(20),
	adr varchar(50),
    Num_tel varchar(20)
);
create table if not exists Typee(
	NomType varchar(20) not null primary key,
    NomCons varchar(20),
    Puissance varchar(20),
    Nb_Places int check (Nb_Places>8)
);
create table if not exists Avion(
	Immatriculation varchar(20),
    Date_achet date not null,
    NomPro varchar(20) not null,
    NomType varchar(20) not null,
    primary key (Immatriculation,NomPro),
    foreign key (NomPro) references Proprietaire(NomPro),
	foreign key (NomType) references Typee(NomType)

);

create table if not exists Habilitation(
    IDMec int not null ,
	NomType varchar(20) not null,
	foreign key (IDMec) references Mecanicien(IDMec),
	foreign key (NomType) references Typee(NomType)
);
create table if not exists Piloter(
	IDPil int ,
    Nb_Vols int check(Nb_Vols<20),
    NomType varchar(20) not null,
    primary key (IDPil,NomType),
	foreign key (NomType) references Typee(NomType),
	foreign key (IDPil) references Pilote(IDPil)
);
create table if not exists Intervention(
	Num int not null auto_increment,
	Objet enum("faire","reparer"),
	DAte_int datetime not null,
    Duree int ,
    Immatriculation varchar(20) not null ,
    IDMec_R int not null,
	IDMec_V int not null,
    primary key (Num), 
	foreign key (Immatriculation) references Avion(Immatriculation),
    foreign key (IDMec_R) references Mecanicien(IDMec),
	foreign key (IDMec_V) references Mecanicien(IDMec),
	check (IDMec_R <> IDMec_V) enforced
);

/* insertion */
insert into Typee values('A','Hani','500MW',35);
insert into Typee values('B','Anes','600MW',40);

insert into Proprietaire values('proper1','SBA_800','07777445','civile');
insert into Proprietaire values('proper2','SBA_22','06466445','civile');

insert into Pilote(Nom_brevet,nom,adr,Num_tel) values(100,'mahmoudi','ain_defla','5514');
insert into Pilote(Nom_brevet,nom,adr,Num_tel) values(200,'Mobarki','Boussaada','213154');
insert into Pilote(Nom_brevet,nom,adr,Num_tel) values(300,'kadi','attaf','1245388');

insert into Mecanicien(Nom,adr,Num_tel) values('karim','alger','551214');
insert into Mecanicien(Nom,adr,Num_tel) values('walid','oran','21314554');
insert into Mecanicien(Nom,adr,Num_tel) values('amir','djelfa','124584388');
insert into Mecanicien(Nom,adr,Num_tel) values('amine','jijel','55101014');
insert into Mecanicien(Nom,adr,Num_tel) values('salim','annaba','21300154');

insert into Piloter values(1,6,'A');
insert into Piloter values(2,8,'A');
insert into Piloter values(3,5,'B');

insert into Avion values('Avion1',"2020-10-15",'proper1','A');
insert into Avion values('Avion2',"2025-10-24",'proper1','A');
insert into Avion values('Avion3',"2018-10-19",'proper2','B');

insert into Habilitation values(1,'A');
insert into Habilitation values(2,'A');
insert into Habilitation values(3,'A');
insert into Habilitation values(4,'B');
insert into Habilitation values(5,'B');

/*--Q3--*/
insert into Intervention(Objet,DAte_int,Immatriculation,IDMec_R,IDMec_V) values('reparer',now(),'Avion2',1,2);
/*--Q4--*/
update Intervention
SET DAte_int="2018-10-03"
where Num=1; 
/*--Q5--*/
/* delete from Intervention
where Immatriculation='Avion2';
delete from Avion
where NomType='A'; */
