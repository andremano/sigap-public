/*SIGAP spatial database implementation script. 
Last updated 03-july-2021 by Andre Mano 
Departamento de Informacao Geografica da Sociedade de Historia Natural de Torres Vedras |i.geografica@alt-shn.org
*/

/* 
use this dummy point to help test spatial triggers

begin;
create table testing_points(
oid int,
geom                 geometry(MULTIPOINT,3763));

ALTER TABLE testing_points ADD CONSTRAINT pk_testing_points PRIMARY KEY ( oid );

INSERT INTO testing_points (oid, geom) VALUES
(1, (SELECT ST_GeomFromEWKT('SRID=3763;MULTIPOINT(1 1)')))
end;


use this commands to remove all objects from database

rollback;
DROP SCHEMA public CASCADE;
DROP SCHEMA history CASCADE;
CREATE SCHEMA public;
CREATE EXTENSION postgis;
*/

begin;

CREATE SCHEMA history;

------------------
-- drop objects --
-----------------
/*
DROP TABLE cgp CASCADE;
DROP SEQUENCE cgp_oid_seq CASCADE;
DROP TABLE cmp CASCADE;
DROP SEQUENCE cmp_oid_seq CASCADE;
DROP TABLE disperso CASCADE;
DROP SEQUENCE disperso_oid_seq CASCADE;
DROP TABLE emprestimo CASCADE;
DROP SEQUENCE emprestimo_oid_seq CASCADE;
DROP TABLE equipa CASCADE;
DROP SEQUENCE equipa_oid_seq CASCADE;
DROP TABLE equipa_constituem _tecnico CASCADE;
DROP TABLE especimen CASCADE;
DROP SEQUENCE especimen_oid_seq CASCADE;
DROP TABLE especimen_refere_publicacao CASCADE;
DROP TABLE geologia CASCADE;
DROP SEQUENCE geologia_oid_seq CASCADE;
DROP TABLE geositio CASCADE;
DROP SEQUENCE geositio_oid_seq CASCADE;
DROP TABLE incidente CASCADE;
DROP SEQUENCE incidente_oid_seq CASCADE;
DROP TABLE intervencao CASCADE;
DROP SEQUENCE intervencao_oid_seq CASCADE;
DROP TABLE inventario CASCADE;
DROP SEQUENCE inventario_oid_seq CASCADE;
DROP TABLE jazida CASCADE;
DROP SEQUENCE jazida_oid_seq CASCADE;
DROP TABLE litoestratigrafia CASCADE;
DROP SEQUENCE litoestratigrafia_oid_seq CASCADE;
DROP TABLE municipio CASCADE;
DROP SEQUENCE municipio_oid_seq CASCADE;
DROP TABLE municipio_2011 CASCADE;
DROP SEQUENCE municipio_2011_oid_seq CASCADE;
DROP TABLE ortofotos2004 CASCADE;
DROP SEQUENCE ortofotos2004_oid_seq CASCADE;
DROP TABLE paleositio CASCADE;
DROP SEQUENCE 
_oid_seq CASCADE;
DROP TABLE publicacao CASCADE;
DROP SEQUENCE publicacao_oid_seq CASCADE;
DROP TABLE relatorio_prep CASCADE;
DROP SEQUENCE relatorio_prep_oid_seq CASCADE;
DROP TABLE relatorio_prep_redige_tecnico CASCADE;
DROP TABLE risco CASCADE;
DROP SEQUENCE risco_oid_seq CASCADE;
DROP TABLE taxon CASCADE;
DROP SEQUENCE taxon_oid_seq CASCADE;
DROP TABLE taxon_contem_paleositio CASCADE;
DROP TABLE tecnico CASCADE;
DROP SEQUENCE tecnico_oid_seq CASCADE;
DROP TABLE codelist_bloco CASCADE;
DROP SEQUENCE codelist_bloco_oid_seq CASCADE;
DROP TABLE codelist_era CASCADE;
DROP SEQUENCE codelist_era_oid_seq CASCADE;
DROP TABLE codelist_reino CASCADE;
DROP SEQUENCE codelist_reino_oid_seq CASCADE;
DROP TABLE codelist_tipo_intervencao CASCADE;
DROP SEQUENCE codelist_tipo_intervencao_oid_seq CASCADE;
*/

----------------------
-- create sequences --
----------------------

CREATE SEQUENCE lista_acronimos_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_taxon_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_risco_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_relatorio_prep_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_litoestratigrafia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_jazida_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_geositio_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_geologia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_especimen_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_emprestimo_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_disperso_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_paleositio_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_incidente_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_intervencao_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_inventario_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE cgp_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE cmp_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE disperso_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE emprestimo_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE equipa_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE especimen_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE fotografia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE geologia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE geositio_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE incidente_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE intervencao_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE inventario_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE jazida_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE litoestratigrafia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE municipio_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE municipio_2011_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE ortofotos2004_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE paleositio_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE publicacao_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE relatorio_prep_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE risco_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE taxon_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE tecnico_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_bloco_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_era_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_reino_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_tipo_intervencao_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_tipo_fotografia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE history_fotografia_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_coleccao_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_proprietario_oid_seq INCREMENT 1 START 1;

CREATE SEQUENCE codelist_tipologia_oid_seq INCREMENT 1 START 1;





-------------------
-- create tables --
-------------------

CREATE TABLE lista_acronimos (
	 oid				 INTEGER DEFAULT NEXTVAL ('lista_acronimos_oid_seq' ) NOT NULL,
     acronimo			 varchar(100) UNIQUE
);


CREATE TABLE paleositio (
     oid                  integer  DEFAULT NEXTVAL('paleositio_oid_seq')                   NOT NULL,
     acronimo             varchar(100)   UNIQUE      NOT NULL, /* paleositio a0 representa proveniencia indeterminada*/
     acronimo_old         integer            , 
     geologia_oid         integer, /* */
     matriz               varchar(100),
     toponimo             varchar(100),
	 vestigios            varchar(250),
	 especies			   varchar(250),
     data_registo         timestamp,
     equipa               varchar(100)         DEFAULT 'indeterminado' NOT NULL,
     obs                  varchar(256),
     translado            boolean            , 
	 risco                integer, /* */
     municipio            integer, /* */
     municipio_2011        integer, /* */
     litoestratigrafia_oid    integer       DEFAULT 1,
     ortofoto_2004        int, /* */
     folha_cmp            varchar, /* */
     folha_cgp            varchar  /* */
);

CREATE TABLE cgp (
     oid                  integer  DEFAULT NEXTVAL('cgp_oid_seq')                   NOT NULL,
     div50                varchar(100) unique,
	 div100               varchar(100),
	 div250               varchar(100),
     geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE cmp (
     oid                  integer  DEFAULT NEXTVAL('cmp_oid_seq')                   NOT NULL,
     nfolha               varchar(100) UNIQUE NOT NULL,
     geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE disperso (     
     oid                  integer  DEFAULT NEXTVAL('disperso_oid_seq')                   NOT NULL,
     x_wgs84_centroid     real      NOT NULL,
     y_wgs84_centroid     real      NOT NULL,
     x_coor_centroid      real      NOT NULL,
     y_coor_centroid      real      NOT NULL,
     area_m2              real      NOT NULL,
     geom                 geometry(MULTIPOLYGON,3763)
) INHERITS (paleositio);


CREATE TABLE emprestimo (
     oid                  integer  DEFAULT NEXTVAL('emprestimo_oid_seq')                   NOT NULL,
     processo             varchar(100),
     instituicao          varchar(100)    NOT NULL,
     requerente           varchar(100)         NOT NULL, 
     data_devolucao       timestamp       NOT NULL,
     data_registo         timestamp       ,
     data_pedido          timestamp       NOT NULL,
     obs                  varchar(100),
     devolucao            boolean
     
);

CREATE TABLE equipa (
     oid                  integer  DEFAULT NEXTVAL('equipa_oid_seq')                   NOT NULL,
    designacao           varchar(100)        UNIQUE NOT NULL
);

CREATE TABLE fotografia (
     oid                  integer  DEFAULT NEXTVAL('fotografia_oid_seq')   NOT NULL,
     paleositio           varchar(100)       DEFAULT 'a0',
	 geositio             varchar(100)       DEFAULT 'a0',
	 especimen            varchar(100)       DEFAULT 'indeterminado',
	 incidente            varchar(100)       DEFAULT 'a0',
	 intervencao          varchar(100)       DEFAULT 'a0',
	 inventario           varchar(100)       DEFAULT 'indeterminado',
	 "file_name"            varchar(255)        NOT NULL,
	 tipo_fotografia      varchar(100)       DEFAULT 'indeterminado',
     source_file          varchar(255)       DEFAULT 'indeterminado',
     image_size           varchar(100),
     megapixels           decimal,
     file_size            varchar(100),
     camera               varchar(100),
     date                 timestamp,
     exif_height          integer,
     exif_widht           integer,
	 exposure_time        varchar(100),
     aperture             decimal,
	 iso                  integer
);

CREATE TABLE especimen (
     oid                  integer  DEFAULT NEXTVAL('especimen_oid_seq')   NOT NULL,
     especimen            varchar(100)       UNIQUE  NOT NULL,
     paleositio           varchar(100)       DEFAULT 'a0',
	 tipo_fossil		  varchar(100)		 DEFAULT 'somatofóssil' NOT NULL,
     taxon                varchar(100)       DEFAULT 'indeterminado' NOT NULL,
	 elementos			  varchar(100),
	 material_associado	  varchar(255),
     coleccao             varchar(100)      NOT NULL,
	 proprietario         varchar(100)      DEFAULT 'Câmara Municipal de Torres Vedras' NOT NULL,
     doaccao              boolean           DEFAULT 'False',
	 doador               varchar(255),
	 bacia				  varchar(100),
	 "sub-bacia"			  varchar(100),
	 formacao			  varchar(100),
	 membro				  varchar(100),
     bloco                varchar,
     caixa                varchar(100),
	 loc_administrativa   varchar(255),
	 obs                  varchar(255),
     data_registo         timestamp
);

alter table especimen
add constraint check_doacao check (CASE when doaccao = 'true' then doador is not null else doador = 'nao se aplica' end);

CREATE TABLE geologia (
     oid                  integer  DEFAULT NEXTVAL('geologia_oid_seq')                   NOT NULL,
     geologia             varchar(100)      ,
     eon                  varchar(100) DEFAULT 'Fanerozoico'  NOT NULL,
     era                  varchar(50)       ,
     periodo              varchar(100)      ,
     epoca                varchar(100)      ,
     idade                varchar(100)      , 
     litologia            varchar(100)      ,	 
     cod_lito             varchar(100)      ,
     nomenclatura         int               ,
     area_m2              real              ,
     /*intervencao_oid      integer           DEFAULT 'sem intervencao',  VERIFICAr*/
     geom                 geometry(MULTIPOLYGON,3763)  
);

CREATE TABLE geositio (
     oid                  integer  DEFAULT NEXTVAL('geositio_oid_seq')                   NOT NULL,
     acronimo             varchar(100)    UNIQUE,
     descricao            varchar(256)         NOT NULL,  
     geologia_oid         integer, /* */
	 municipio_2011       integer, /* */
     folha_cmp            varchar(100), /* */           
     folha_cgp            varchar(100), /* */
     ortofoto_2004        integer  DEFAULT 0, 	 
     geom                 geometry(MULTIPOINT,3763)
);

CREATE TABLE incidente (
     oid                  integer  DEFAULT NEXTVAL('incidente_oid_seq')                   NOT NULL,
	 codigo               varchar(100)    UNIQUE NOT NULL DEFAULT 'i'||nextval('incidente_oid_seq')::text,
     descricao            varchar(100)         NOT NULL,
     contacto             varchar(100)         NOT NULL,
     data_ocorrencia      timestamp      NOT NULL,
     data_registo         timestamp         NOT NULL,
     ortofoto_2004        integer, /* */
     folha_cgp            varchar(100), /* */
     folha_cmp            varchar(100), /* */
     geologia_oid         integer, /* */
     municipio_2011       integer, /* */
	 risco				  integer,
     geom                 geometry(POINT,3763)                 NOT NULL    
);

CREATE TABLE intervencao (
     oid                  integer  DEFAULT NEXTVAL('intervencao_oid_seq')                   NOT NULL,
     codigo               varchar(100)    UNIQUE NOT NULL,
     tipo_interv          varchar         NOT NULL,
     data_inicio          timestamp       NOT NULL,
     data_fim             timestamp,
     tecnico              varchar(100),
     relatorio_interv     varchar(100),  
     municipio            integer, /* */
	 paleositio           varchar(100)       DEFAULT 'a0',
     municipio_2011       varchar(100)       DEFAULT 'a0',
	 folha_cgp            varchar, /* */
	 folha_cmp            varchar(100), /* */
	 ortofoto_2004        integer, /* */
     geologia_oid         integer, /* */
     geom                 geometry(MULTIPOINT,3763)  not null
);

CREATE TABLE inventario (
     oid                  integer  DEFAULT NEXTVAL('inventario_oid_seq')                   NOT NULL,
     peca                 varchar(100) UNIQUE NOT NULL,
     fragmento            varchar(100),
     especimen            varchar(100)   NOT NULL DEFAULT 'indeterminado',
     observacoes          varchar(100),
     elem_osteologico     varchar(100)
);

CREATE TABLE jazida (
     oid                  integer  DEFAULT NEXTVAL('jazida_oid_seq')                   NOT NULL,
     in_situ              boolean,
     x_coor               real               NOT NULL,
     y_coor               real               NOT NULL,
     y_wgs84              real               NOT NULL,
     x_wgs84              real               NOT NULL,
     dop                  real               ,
     num_satelites        int,
     cota                 int                 ,
     precisao             varchar(100),
     geom                 geometry(MULTIPOINT,3763)
) INHERITS (paleositio);


CREATE TABLE litoestratigrafia (
     oid                  integer  DEFAULT NEXTVAL('litoestratigrafia_oid_seq')                   NOT NULL,
     pai                  varchar(100),
     nome_completo        varchar(100),
     nivel                varchar(100),
     notas                varchar(100),
     nome                 varchar(100)         NOT NULL
);

CREATE TABLE municipio (
     oid                  integer  DEFAULT NEXTVAL('municipio_oid_seq')                   NOT NULL,
	 dicofre              varchar(250)    NOT NULL,
     freguesia            varchar(250)         NOT NULL,
     concelho             varchar(250)         NOT NULL,
	 distrito             varchar(250)         NOT NULL,
	 taa                  varchar(250)         ,
     area_ea_ha           real             ,
	 area_t_ha            real             ,
	 des_simpli           varchar(250)     ,
     area_km2             real             ,
     geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE municipio_2011 (
     oid                  integer  DEFAULT NEXTVAL('municipio_2011_oid_seq')                   NOT NULL,
	 dicofre              integer   UNIQUE NOT NULL,
     freguesia            varchar(100)         NOT NULL,
     municipio            varchar(100)         NOT NULL,
	 taa                  varchar(100)         ,
	 distrito             varchar(100)         NOT NULL,
     area_ea_ha           real             ,
	 area_t_ha            real             ,
     area_km2             real             ,
     geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE ortofotos2004 (
     oid                  integer  DEFAULT NEXTVAL('ortofotos2004_oid_seq')                   NOT NULL,
     numero               int        UNIQUE       NOT NULL,
     geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE publicacao (
     oid                  integer  DEFAULT NEXTVAL('publicacao_oid_seq')                   NOT NULL,
     issn_isbn            varchar(100)      UNIQUE,
     revista              varchar(100),
     editora              varchar(100),
     ano                  varchar(100),
     autores              varchar(100),
     titulo               varchar(100)
     
);

CREATE TABLE relatorio_prep (
     oid                  integer  DEFAULT NEXTVAL('relatorio_prep_oid_seq')                   NOT NULL,
     id_relatorio         varchar(100)      UNIQUE NOT NULL,
	 preparador			  varchar(100) 		DEFAULT 'indeterminado' NOT NULL,
     data_abertura        timestamp         NOT NULL,
     data_conclusao       timestamp,
     especimen            varchar(100)      DEFAULT 'indeterminado' NOT NULL
     
);

CREATE TABLE risco (
     oid                  integer  DEFAULT NEXTVAL('risco_oid_seq')                   NOT NULL,
     legenda              varchar(100)         NOT NULL,
     area_m2              real              ,
     geom                 geometry(MULTIPOLYGON,3763),
     nivel                int                NOT NULL
);

CREATE TABLE taxon (
     oid                  integer  DEFAULT NEXTVAL('taxon_oid_seq')                   NOT NULL,
     taxon                varchar(100)         UNIQUE  NOT NULL,
     reino                varchar(50)                  NOT NULL,
     phylum               varchar(100)         ,
     subphylum            varchar(100)         ,
     classe               varchar(100)         ,
     subclasse            varchar(100)         ,
     superordem           varchar(100)         ,
     ordem                varchar(100)         ,
     subordem             varchar(100)         ,
     infraordem           varchar(100)         ,
     familia              varchar(100)         ,
     subfamilia           varchar(100)         ,
     genero               varchar(100)         ,
     especie              varchar(100)         ,
     subespecie           varchar(100)            
);

CREATE TABLE tecnico (
     oid                  integer  DEFAULT NEXTVAL('tecnico_oid_seq')                   NOT NULL,
     numero_socio         int,
     telefone             int,
     apelido              varchar(100)         NOT NULL,
     iniciais             varchar(100)         UNIQUE NOT NULL,
     email                varchar(100),
     socio                boolean,
     nome                 varchar(100)         NOT NULL,
     tipo_socio           varchar(100)         NOT NULL
);

CREATE TABLE extent_ortos (
oid					 int,
geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE extent_geologia (
oid					 int,
geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE extent_cgp (
oid					 int,
geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE extent_cmp (
oid					 int,
geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE extent_municipios (
oid					 int,
geom                 geometry(MULTIPOLYGON,3763)
);

CREATE TABLE codelist_era (
     oid                  integer  DEFAULT NEXTVAL('codelist_era_oid_seq')                   NOT NULL,
     value                varchar(50)        UNIQUE  NOT NULL
);

CREATE TABLE codelist_reino (
     oid                  integer  DEFAULT NEXTVAL('codelist_reino_oid_seq')                   NOT NULL,
     value                varchar(50)         UNIQUE NOT NULL
);

CREATE TABLE codelist_tipo_intervencao (
     oid                  integer  DEFAULT NEXTVAL('codelist_tipo_intervencao_oid_seq')                   NOT NULL,
     value                varchar(50)        UNIQUE  NOT NULL
);

CREATE TABLE codelist_tipo_fotografia (
     oid                  integer  DEFAULT NEXTVAL('codelist_tipo_fotografia_oid_seq')                   NOT NULL,
     value                varchar(50)        UNIQUE  NOT NULL
);

CREATE TABLE codelist_coleccao (
     oid                  integer  DEFAULT NEXTVAL('codelist_coleccao_oid_seq')                   NOT NULL,
     value                varchar(100)         UNIQUE NOT NULL
);

CREATE TABLE codelist_proprietario (
     oid                  integer  DEFAULT NEXTVAL('codelist_proprietario_oid_seq')                   NOT NULL,
     value                varchar(100)         UNIQUE NOT NULL
);

CREATE TABLE codelist_tipologia (
     oid                  integer  DEFAULT NEXTVAL('codelist_tipologia_oid_seq')                   NOT NULL,
     value                varchar(100)         UNIQUE NOT NULL
);


-------------------
-- taxon history --
-------------------

CREATE TABLE history.taxon(
     oid                  integer  DEFAULT NEXTVAL ( 'history_taxon_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 taxon                varchar(100),
     reino                varchar(50),
     phylum               varchar(100),
     subphylum            varchar(100),
     classe               varchar(100),
     subclasse            varchar(100),
     superordem           varchar(100),
     ordem                varchar(100),
     subordem             varchar(100),
     infraordem           varchar(100),
     familia              varchar(100),
     subfamilia           varchar(100),
     genero               varchar(100),
     especie              varchar(100),
     subespecie           varchar(100)            
);

-------------------
-- risco history --
-------------------

CREATE TABLE history.risco(
     oid                  integer  DEFAULT NEXTVAL ( 'history_risco_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 legenda              varchar(100),
     area_m2              real,
     geom                 geometry(MULTIPOLYGON,3763),
     nivel                int
);

----------------------------
-- relatorio_prep history --
----------------------------

CREATE TABLE history.relatorio_prep(
     oid                  integer  DEFAULT NEXTVAL ( 'history_relatorio_prep_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 id_relatorio         varchar(100),
	 preparador			  varchar(100),
     data_abertura        timestamp,
     data_conclusao       timestamp,
     especimen            varchar(100)
);

-------------------------------
-- litoestratigrafia history --
-------------------------------

CREATE TABLE history.litoestratigrafia(
     oid                  integer  DEFAULT NEXTVAL ( 'history_litoestratigrafia_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 pai                  varchar(100),
     nome_completo        varchar(100),
     nivel                varchar(100),
     notas                varchar(100),
     nome                 varchar(100)       
);

--------------------
-- jazida history --
--------------------

CREATE TABLE history.jazida(
     oid                  integer  DEFAULT NEXTVAL ( 'history_jazida_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 in_situ              boolean,
     x_coor               real,
     y_coor               real,
     y_wgs84              real,
     x_wgs84              real,
     dop                  real,
     num_satelites        int,
     cota                 int,
     precisao             varchar(100),
     geom                 geometry(MULTIPOINT,3763)
);	 

----------------------
-- geositio history --
----------------------

CREATE TABLE history.geositio(
     oid                  integer  DEFAULT NEXTVAL ( 'history_geositio_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,
     acronimo             varchar(100),
     descricao            varchar(100),  
     geologia_oid         integer,
	 municipio_2011            integer,
     ortofoto_2004        integer,
     folha_cmp            varchar(100),
     folha_cgp            varchar,
     geom                 geometry(MULTIPOINT,3763)
);

----------------------
-- geologia history --
----------------------

CREATE TABLE history.geologia(
     oid                  integer  DEFAULT NEXTVAL ( 'history_geologia_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 geologia             varchar(100),
     eon                  varchar(100),
     era                  varchar(50),
     periodo              varchar(100),
     epoca                varchar(100),
     idade                varchar(100), 
     litologia            varchar(100),	 
     cod_lito             varchar(100),
     nomenclatura         int,
     area_m2              real ,
     geom                 geometry(MULTIPOLYGON,3763) 
);

-----------------------
-- especimen history --
-----------------------

CREATE TABLE history.especimen(
     oid                  integer  DEFAULT NEXTVAL ( 'history_especimen_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,
     especimen            varchar(100),
     paleositio           varchar(100),
	 tipo_fossil		  varchar(100),
     taxon                varchar(100),
	 elementos			  varchar(100),
	 material_associado	  varchar(255),
     coleccao             varchar(100),
	 proprietario         varchar(100),
     doaccao              boolean,
	 doador               varchar(255),
	 bacia				  varchar(100),
	 "sub-bacia"			  varchar(100),
	 formacao			  varchar(100),
	 membro				  varchar(100),
     bloco                varchar,
     caixa                varchar(100),
	 loc_administrativa   varchar(255),
	 obs                  varchar(255),
     data_registo         timestamp
);

------------------------
-- emprestimo history --
------------------------

CREATE TABLE history.emprestimo(
     oid                  integer  DEFAULT NEXTVAL ( 'history_emprestimo_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid         integer,
	 processo             varchar(100),
     instituicao          varchar(100),
     requerente           varchar(100), 
     data_devolucao       timestamp,
     data_registo         timestamp,
     data_pedido          timestamp,
     obs                  varchar(100),
     devolucao            boolean        
);

----------------------
-- disperso history --
----------------------

CREATE TABLE history.disperso (
     oid                  integer  DEFAULT NEXTVAL ( 'history_disperso_oid_seq' ) PRIMARY KEY,
     operacao             varchar(100),
     data                 timestamp,
     tecnico              varchar(100),
	 original_oid		  integer,
     x_wgs84_centroid     real,
     y_wgs84_centroid     real,
     x_coor_centroid      real,
     y_coor_centroid      real,
     area_m2              real,
     geom                 geometry(MULTIPOLYGON,3763)           
);

------------------------
-- paleositio history --
------------------------

CREATE TABLE history.paleositio (
     oid                  integer  DEFAULT NEXTVAL ( 'history_paleositio_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,
     acronimo             varchar(100),
     acronimo_old         int, 
     especies             varchar(100),
     geologia_oid         integer,
     matriz               varchar(100),
     toponimo             varchar(100),
     data_registo         timestamp,
     equipa               varchar(100),
     obs                  varchar(256),
     translado            boolean, 
	 risco                integer,
     municipio            integer,
     municipio_2011        integer,
     litoestratigrafia_oid    integer,
     ortofoto_2004        int,
     folha_cmp            varchar,
     folha_cgp            varchar       
);

-----------------------
-- incidente history --
-----------------------

CREATE TABLE history.incidente (
     oid                  integer  DEFAULT NEXTVAL ( 'history_incidente_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,
	 codigo               varchar(100),
     descricao            varchar(100),
     contacto             varchar(100),
	 fotografia           varchar(100),
	 risco				  integer,
     data_ocorrencia      timestamp,
     data_registo         timestamp,
     ortofoto_2004        integer,
     folha_cgp            varchar(100),
     folha_cmp            varchar(100),
     geologia_oid         integer,
     municipio_2011       integer,
     geom                 geometry(POINT,3763)                
);

-------------------------
-- intervencao history --
-------------------------

CREATE TABLE history.intervencao (
     oid                  integer  DEFAULT NEXTVAL ( 'history_intervencao_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,	
     codigo               varchar(100),
     tipo_interv          varchar,
     data_inicio          timestamp,
     data_fim             timestamp,
	 fotografia           varchar(100),
     relatorio_interv     varchar(100),  
     municipio            integer,
	 municipio_2011       varchar(100),
     folha_cgp            varchar,
	 folha_cmp            varchar(100),
	 ortofoto_2004        integer,
     geologia_oid         integer,
     geom                 geometry(MULTIPOINT,3763)         
);

------------------------
-- inventario history --
------------------------

CREATE TABLE history.inventario (
     oid                  integer  DEFAULT NEXTVAL ( 'history_inventario_oid_seq' ) PRIMARY KEY,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,	
     peca                 varchar(100),
     fragmento            varchar(100),
     especimen            varchar(100),
	 fotografia           varchar(100),
     observacoes          varchar(100),
     elem_osteologico     varchar(100)                
);
/*
CREATE TABLE history.fotografia (
     oid                  integer  DEFAULT NEXTVAL('history_fotografia_oid_seq')   NOT NULL,
	 operacao             varchar(100),
     data                 timestamp,
	 tecnico              varchar(100),
	 original_oid		  integer,
     photo_number         varchar(100) ,
     paleositio           varchar(100),
	 geositio             varchar(100),
	 especimen            varchar(100),
	 incidente            varchar(100),
	 intervencao          varchar(100),
	 inventario           varchar(100),
	 tipo_fotografia      varchar(100),
     source_file          varchar(255),
	 "file_name"            varchar(100),
     image_size           varchar(100),
     megapixels           decimal,
     file_size            varchar(100),
     camera               varchar(100),
     date                 timestamp,
     exif_height          integer,
     exif_widht           integer,
	 exposure_time        varchar(100),
     aperture             decimal,
	 iso                  integer
);
*/
----------------------------------
-- Insert values into codelists --
----------------------------------

Insert into codelist_era (oid, value) VALUES ( 1, 'Cenozoico');
Insert into codelist_era (oid, value) VALUES ( 2, 'Mesozoico');
Insert into codelist_era (oid, value) VALUES ( 3, 'indeterminado');

Insert into codelist_reino (oid, value) VALUES ( 1, 'Animalia');
Insert into codelist_reino (oid, value) VALUES ( 2, 'Plantae');
Insert into codelist_reino (oid, value) VALUES ( 3, 'indeterminado');

Insert into codelist_tipo_intervencao (oid, value) VALUES ( 1, 'acompanhamento');
Insert into codelist_tipo_intervencao (oid, value) VALUES ( 2, 'escavacao');
Insert into codelist_tipo_intervencao (oid, value) VALUES ( 3, 'monitorizacao');
Insert into codelist_tipo_intervencao (oid, value) VALUES ( 4, 'resgate');
Insert into codelist_tipo_intervencao (oid, value) VALUES ( 5, 'indeterminado');

Insert into codelist_tipo_fotografia (oid, value) VALUES ( 1, 'paleositio');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 2, 'geositio');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 3, 'especimen');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 4, 'incidente');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 5, 'intervencao');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 6, 'inventario');
Insert into codelist_tipo_fotografia  (oid, value) VALUES ( 6, 'indeterminado');

-------------------------
-- Create Primary Keys --
-------------------------


ALTER TABLE lista_acronimos ADD CONSTRAINT pk_lista_acronimos PRIMARY KEY ( oid );
ALTER TABLE cgp ADD CONSTRAINT pk_cgp PRIMARY KEY ( oid );
ALTER TABLE cmp ADD CONSTRAINT pk_cmp PRIMARY KEY ( oid );
ALTER TABLE disperso ADD CONSTRAINT pk_disperso PRIMARY KEY ( oid );
ALTER TABLE emprestimo ADD CONSTRAINT pk_emprestimo PRIMARY KEY ( oid );
ALTER TABLE equipa ADD CONSTRAINT pk_equipa PRIMARY KEY ( oid );
ALTER TABLE especimen ADD CONSTRAINT pk_especimen PRIMARY KEY ( oid );
ALTER TABLE fotografia ADD CONSTRAINT pk_fotografia PRIMARY KEY ( oid );
ALTER TABLE geologia ADD CONSTRAINT pk_geologia PRIMARY KEY ( oid );
ALTER TABLE geositio ADD CONSTRAINT pk_geositio PRIMARY KEY ( oid );
ALTER TABLE incidente ADD CONSTRAINT pk_incidente PRIMARY KEY ( oid );
ALTER TABLE intervencao ADD CONSTRAINT pk_intervencao PRIMARY KEY ( oid );
ALTER TABLE inventario ADD CONSTRAINT pk_inventario PRIMARY KEY ( oid );
ALTER TABLE jazida ADD CONSTRAINT pk_jazida PRIMARY KEY ( oid );
ALTER TABLE litoestratigrafia ADD CONSTRAINT pk_litoestratigrafia PRIMARY KEY ( oid );
ALTER TABLE municipio ADD CONSTRAINT pk_municipios PRIMARY KEY ( oid );
ALTER TABLE municipio_2011 ADD CONSTRAINT pk_municipio_2011 PRIMARY KEY ( oid );
ALTER TABLE ortofotos2004 ADD CONSTRAINT pk_ortofotos2004 PRIMARY KEY ( oid );
ALTER TABLE paleositio ADD CONSTRAINT pk_paleositio PRIMARY KEY ( oid );
ALTER TABLE publicacao ADD CONSTRAINT pk_publicacao PRIMARY KEY ( oid );
ALTER TABLE relatorio_prep ADD CONSTRAINT pk_relatorio_prep PRIMARY KEY ( oid );
ALTER TABLE risco ADD CONSTRAINT pk_risco PRIMARY KEY ( oid );
ALTER TABLE taxon ADD CONSTRAINT pk_taxon PRIMARY KEY ( oid );
ALTER TABLE tecnico ADD CONSTRAINT pk_tecnico PRIMARY KEY ( oid );
ALTER TABLE codelist_era ADD CONSTRAINT pk_codelist_era PRIMARY KEY ( oid );
ALTER TABLE codelist_reino ADD CONSTRAINT pk_codelist_reino PRIMARY KEY ( oid );
ALTER TABLE codelist_tipo_intervencao ADD CONSTRAINT pk_codelist_tipo_intervencao PRIMARY KEY ( oid );
ALTER TABLE extent_ortos ADD CONSTRAINT pk_extent_ortos PRIMARY KEY ( oid );
ALTER TABLE extent_geologia ADD CONSTRAINT pk_extent_geologia PRIMARY KEY ( oid );
ALTER TABLE extent_cgp ADD CONSTRAINT pk_extent_cgp PRIMARY KEY ( oid );
ALTER TABLE extent_cmp ADD CONSTRAINT pk_extent_cmp PRIMARY KEY ( oid );
ALTER TABLE extent_municipios ADD CONSTRAINT pk_extent_municipios PRIMARY KEY ( oid );

ALTER TABLE codelist_coleccao ADD CONSTRAINT pk_coleccao PRIMARY KEY ( oid );
ALTER TABLE codelist_proprietario ADD CONSTRAINT pk_proprietario PRIMARY KEY ( oid );
ALTER TABLE codelist_tipologia ADD CONSTRAINT pk_tipologia PRIMARY KEY ( oid );




-------------------------
-- Create Foreign Keys --
-------------------------

ALTER TABLE disperso ADD CONSTRAINT fk_cgp_disperso FOREIGN KEY ( folha_cgp ) REFERENCES cgp ( div50  ); -- apply over paleositio instead?
ALTER TABLE disperso ADD CONSTRAINT fk_cmp_disperso FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  ); -- apply over paleositio instead?


ALTER TABLE public.especimen ADD CONSTRAINT fk_proveniencia FOREIGN KEY (paleositio) REFERENCES public.lista_acronimos (acronimo);
ALTER TABLE especimen ADD CONSTRAINT fk_taxon FOREIGN KEY ( taxon ) REFERENCES taxon ( taxon  );

ALTER TABLE public.fotografia ADD CONSTRAINT fk_acronimo_paleositio FOREIGN KEY (paleositio) REFERENCES public.lista_acronimos (acronimo);
ALTER TABLE fotografia ADD CONSTRAINT fk_geositio FOREIGN KEY ( geositio ) REFERENCES geositio ( acronimo  );
ALTER TABLE fotografia ADD CONSTRAINT fk_especimen FOREIGN KEY ( especimen ) REFERENCES especimen ( especimen  );
ALTER TABLE fotografia ADD CONSTRAINT fk_incidente FOREIGN KEY ( incidente ) REFERENCES incidente ( codigo  );
ALTER TABLE fotografia ADD CONSTRAINT fk_intervencao FOREIGN KEY ( intervencao ) REFERENCES intervencao ( codigo  );
ALTER TABLE fotografia ADD CONSTRAINT fk_inventario FOREIGN KEY ( inventario ) REFERENCES inventario ( peca  );
ALTER TABLE fotografia ADD CONSTRAINT fk_codelist_tipo_fotografia FOREIGN KEY ( tipo_fotografia ) REFERENCES codelist_tipo_fotografia ( value  );

ALTER TABLE relatorio_prep ADD CONSTRAINT fk_relatorio_prep FOREIGN KEY ( especimen ) REFERENCES especimen ( especimen  );
ALTER TABLE relatorio_prep ADD CONSTRAINT fk_tecnico_prep FOREIGN KEY ( preparador ) REFERENCES tecnico ( iniciais  );


ALTER TABLE geologia ADD CONSTRAINT fk_codelist_era FOREIGN KEY ( era ) REFERENCES codelist_era ( value  );

ALTER TABLE geositio ADD CONSTRAINT fk_associado FOREIGN KEY ( geologia_oid ) REFERENCES geologia ( oid  );
ALTER TABLE geositio ADD CONSTRAINT fk_municipio FOREIGN KEY ( municipio_2011 ) REFERENCES municipio_2011 ( oid  );
ALTER TABLE geositio ADD CONSTRAINT fk_cgp_geositio FOREIGN KEY ( folha_cgp ) REFERENCES cgp ( div50  );
ALTER TABLE geositio ADD CONSTRAINT fk_cmp_geositio FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  ); -- apply over paleositio instead?

ALTER TABLE incidente ADD CONSTRAINT fk_contexto_administrativo FOREIGN KEY ( municipio_2011 ) REFERENCES municipio_2011 ( oid  );
ALTER TABLE incidente ADD CONSTRAINT fk_contexto_geologico FOREIGN KEY ( geologia_oid ) REFERENCES geologia ( oid  );
ALTER TABLE incidente ADD CONSTRAINT fk_cgp_incidente FOREIGN KEY ( folha_cgp ) REFERENCES cgp ( div50  );
ALTER TABLE incidente ADD CONSTRAINT fk_cmp_incidente FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  );

ALTER TABLE intervencao ADD CONSTRAINT fk_codelist_tipo_intervencao FOREIGN KEY ( tipo_interv ) REFERENCES codelist_tipo_intervencao ( value  );
--ALTER TABLE intervencao ADD CONSTRAINT fk_incide FOREIGN KEY ( geositio ) REFERENCES geositio ( acronimo  );
ALTER TABLE intervencao ADD CONSTRAINT fk_posicionado FOREIGN KEY ( municipio ) REFERENCES municipio ( oid  );
ALTER TABLE public.intervencao ADD CONSTRAINT fk_responsavel FOREIGN KEY (tecnico) REFERENCES tecnico(iniciais);
ALTER TABLE intervencao ADD CONSTRAINT fk_situado FOREIGN KEY ( geologia_oid ) REFERENCES geologia ( oid  );
ALTER TABLE intervencao ADD CONSTRAINT fk_cgp_intervencao FOREIGN KEY ( folha_cgp ) REFERENCES cgp ( div50  );
ALTER TABLE intervencao ADD CONSTRAINT fk_cmp_intervencao FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  ); -- apply over paleositio instead?

--ALTER TABLE jazida ADD CONSTRAINT fk_cgp_jazida FOREIGN KEY ( folha_cgp ) REFERENCES cgp ( div50  ); -- apply over paleositio instead?
--ALTER TABLE jazida ADD CONSTRAINT fk_cmp_jazida FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  ); -- apply over paleositio instead?

ALTER TABLE inventario ADD CONSTRAINT fk_pertence FOREIGN KEY ( especimen ) REFERENCES especimen ( especimen  );

ALTER TABLE paleositio ADD CONSTRAINT fk_contextualiza FOREIGN KEY ( geologia_oid ) REFERENCES geologia ( oid  );
ALTER TABLE paleositio ADD CONSTRAINT fk_enquadra FOREIGN KEY ( litoestratigrafia_oid ) REFERENCES litoestratigrafia ( oid  );
ALTER TABLE paleositio ADD CONSTRAINT fk_localizado FOREIGN KEY ( municipio_2011 ) REFERENCES municipio_2011 ( oid  );
ALTER TABLE paleositio ADD CONSTRAINT fk_regista FOREIGN KEY ( equipa ) REFERENCES equipa ( designacao  );
ALTER TABLE paleositio ADD CONSTRAINT fk_sito FOREIGN KEY ( municipio ) REFERENCES municipio ( oid  );
ALTER TABLE paleositio ADD CONSTRAINT fk_cmp FOREIGN KEY ( folha_cmp ) REFERENCES cmp ( nfolha  );
ALTER TABLE paleositio ADD CONSTRAINT fk_risco FOREIGN KEY ( risco ) REFERENCES risco ( oid  );

ALTER TABLE taxon ADD CONSTRAINT fk_codelist_reino FOREIGN KEY ( reino ) REFERENCES codelist_reino ( value  );

ALTER TABLE especimen ADD CONSTRAINT fk_codelist_coleccao FOREIGN KEY ( coleccao ) REFERENCES codelist_coleccao ( value  );

ALTER TABLE especimen ADD CONSTRAINT fk_codelist_proprietario FOREIGN KEY ( proprietario ) REFERENCES codelist_proprietario ( value  );

ALTER TABLE especimen ADD CONSTRAINT fk_codelist_tipologia FOREIGN KEY ( tipo_fossil ) REFERENCES codelist_tipologia ( value  );

----------------------------
-- Create Spatial Indexes --
----------------------------

CREATE INDEX idx_cgp_geom ON cgp USING GIST ( geom );
CREATE INDEX idx_cmp_geom ON cmp USING GIST ( geom );
CREATE INDEX idx_disperso_geom ON disperso USING GIST ( geom );
CREATE INDEX idx_geologia_geom ON geologia USING GIST ( geom );
CREATE INDEX idx_geositio_geom ON geositio USING GIST ( geom );
CREATE INDEX idx_intervencao_geom ON intervencao USING GIST ( geom );
CREATE INDEX idx_jazida_geom ON jazida USING GIST ( geom );
CREATE INDEX idx_municipio_geom ON municipio USING GIST ( geom );
CREATE INDEX idx_municipio_2011_geom ON municipio_2011 USING GIST ( geom );
CREATE INDEX idx_ortofotos2004_geom ON ortofotos2004 USING GIST ( geom );
CREATE INDEX idx_risco_geom ON risco USING GIST ( geom );
    
                                                --*******************************************
                                                --  IN TABLE FUNCTIONS  IN TABLE FUNCTIONS --                                    
                                                --*******************************************
                                                                                                                     
-----------------------------------------------------------------------------------------
-- Trigger function to get data_registo into table incidente  -- CHECKED!
-----------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_date()
  RETURNS trigger AS
$BODY$
    BEGIN
        NEW.data_registo := current_timestamp;
        RETURN NEW;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
  
 CREATE TRIGGER get_date
  BEFORE INSERT 
  ON incidente
  FOR EACH ROW
  EXECUTE PROCEDURE get_Date(); 
  
  
  -----------------------------------------------------------------------------------------
-- Trigger function to update the area attribute of tables geologia, risco e disperso  -- CHECKED!
-----------------------------------------------------------------------------------------

  

CREATE OR REPLACE FUNCTION computing_area()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.area_m2 := ROUND((st_area(NEW.geom))::numeric,2); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_area_geologia
  BEFORE INSERT OR UPDATE
  ON geologia
  FOR EACH ROW
  EXECUTE PROCEDURE computing_area();

  CREATE TRIGGER calculate_area_risco
  BEFORE INSERT OR UPDATE
  ON risco
  FOR EACH ROW
  EXECUTE PROCEDURE computing_area();

  CREATE TRIGGER calculate_area_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON disperso
  FOR EACH ROW
  EXECUTE PROCEDURE computing_area();
  
---------------------------------------------------------------------------------
-- Trigger function to update the x_coor_centroid attribute of table disperso  -- CHECKED!
---------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_x_coor_centroid()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.x_coor_centroid := ROUND(st_x(st_centroid(NEW.geom))::numeric, 2);
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_x_centroid -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON disperso  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_x_coor_centroid();

---------------------------------------------------------------------------------
-- Trigger function to update the y_coor_centroid attribute of table disperso  -- CHECKED!
---------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_y_coor_centroid()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.y_coor_centroid := ROUND(st_y(st_centroid(NEW.geom))::numeric, 2); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_y_centroid -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON disperso  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_y_coor_centroid();
  
  --------------------------------------------------------------------------------
-- Trigger function to update the x_wgs84_centroid attribute of table disperso  -- CHECKED!
----------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_x_wgs84_centroid()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.x_wgs84_centroid := ROUND(st_y(st_centroid(st_transform(NEW.geom,4326)))::numeric, 8); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_x_wgs84_centroid -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON disperso  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_x_wgs84_centroid();

----------------------------------------------------------------------------------
-- Trigger function to update the y_wgs84_centroid attribute of table disperso  -- CHECKED!
----------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_y_wgs84_centroid()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.y_wgs84_centroid := ROUND(st_y(st_centroid(st_transform(NEW.geom,4326)))::numeric, 8); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_y_wgs84_centroid -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON disperso  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_y_wgs84_centroid();

----------------------------------------------------------------------
-- Trigger function to update the x_coor attribute of table jazida  -- CHECKED!
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_x_coor()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.x_coor := ROUND(st_x(st_centroid(NEW.geom))::numeric, 2);
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_x -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON jazida  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_x_coor();

-------------------------------------------------------------------------------
-- Trigger function to update the y_coor_centroid attribute of table jazida  -- CHECKED!
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_y_coor()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.y_coor := ROUND(st_y(st_centroid(NEW.geom))::numeric, 2); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_y -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON jazida  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_y_coor();
  
--------------------------------------------------------------------------------
-- Trigger function to update the x_wgs84 attribute of table jazida  -- CHECKED!
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_x_wgs84()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.x_wgs84 := ROUND(st_y(st_centroid(st_transform(NEW.geom,4326)))::numeric, 8); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_x_wgs84 -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON jazida  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_x_wgs84();

--------------------------------------------------------------------------------
-- Trigger function to update the y_wgs84 attribute of table jazida  -- CHECKED!
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION computing_y_wgs84()
  RETURNS TRIGGER AS
$BODY$
   BEGIN      
       NEW.y_wgs84 := ROUND(st_y(st_centroid(st_transform(NEW.geom,4326)))::numeric, 8); 
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER calculate_y_wgs84 -- CHECKED!
  BEFORE INSERT OR UPDATE
  ON jazida  
  FOR EACH ROW
  EXECUTE PROCEDURE computing_y_wgs84();

END;
-------------------------------------------------------------------------------------------------------------------
-- Trigger function to update the ortofotos_2004 of table jazida, disperso, intervencao, geositio and incidente  -- CHECKED!
--------------- (assumes the shapefile called "ortofoto_unioned" has been loaded into the database ----------------
-------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.get_ortofoto2004()
 RETURNS trigger
 AS
$BODY$
   BEGIN 
        IF 
	     (SELECT st_intersects(st_centroid(NEW.geom), st_union(o.geom)) from ortofotos2004 as o) = 'False' -- assumes shapefile, built from unioning all ortofotos polygons
	   THEN 
	     SELECT 0 INTO NEW.ortofoto_2004;
	   ELSE
         SELECT o.numero INTO NEW.ortofoto_2004 from ortofotos2004 as o where st_intersects(st_centroid(NEW.geom), o.geom);
	   END IF;
       RETURN NEW;
   END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER get_ortofoto_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida  
  FOR each row
  EXECUTE PROCEDURE get_ortofoto2004();
  
CREATE TRIGGER get_ortofoto_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso  
  FOR each row
  EXECUTE PROCEDURE get_ortofoto2004();

CREATE TRIGGER get_ortofoto_incidente
  BEFORE INSERT OR UPDATE ON incidente  
  FOR each row
  EXECUTE PROCEDURE get_ortofoto2004();
  
CREATE TRIGGER get_ortofoto_geositio
  BEFORE INSERT OR UPDATE ON geositio  
  FOR each row
  EXECUTE PROCEDURE get_ortofoto2004();
  
CREATE TRIGGER get_ortofoto_intervencao
  BEFORE INSERT OR UPDATE ON intervencao  
  FOR each row
  EXECUTE PROCEDURE get_ortofoto2004();
  
---------------------------------------------------------------------------------------------------------------
-- Trigger function to update the folha_cmp of table jazida, disperso, intervencao, geositio and incidente  --- CHECKED!
---------------- (assumes the shapefile called "cmp_unioned" has been loaded into the database ----------------
---------------------------------------------------------------------------------------------------------------

   CREATE OR REPLACE FUNCTION get_folha_cmp()
  RETURNS TRIGGER AS
$BODY$
   BEGIN 
       IF 
	     (SELECT st_intersects(NEW.geom, e.geom) from extent_cmp as e) = 'false' -- assumes shapefile, built from unioning all cmp polygons
	   THEN 
	     SELECT '0' INTO NEW.folha_cmp;
	   ELSE
         SELECT c.nfolha INTO NEW.folha_cmp from cmp as c where st_intersects(NEW.geom, c.geom);
	   END IF;
	   RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';

CREATE TRIGGER get_folha_cmp_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida
  FOR each row
  EXECUTE PROCEDURE get_folha_cmp();
  
CREATE TRIGGER get_folha_cmp_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso
  FOR each row
  EXECUTE PROCEDURE get_folha_cmp();

CREATE TRIGGER get_folha_cmp_incidente
  BEFORE INSERT OR UPDATE ON incidente  
  FOR each row
  EXECUTE PROCEDURE get_folha_cmp();
  
CREATE TRIGGER get_folha_cmp_geositio
  BEFORE INSERT OR UPDATE ON geositio 
  FOR each row
  EXECUTE PROCEDURE get_folha_cmp();
  
CREATE TRIGGER get_folha_cmp_intervencao
  BEFORE INSERT OR UPDATE ON intervencao
  FOR each row
  EXECUTE PROCEDURE get_folha_cmp();
  
--------------------------------------------------------------------------------------------------------------
-- Trigger function to update the folha_cgp of table jazida, disperso, intervencao, geositio and incidente --- CHECKED!
---------------- (assumes the shapefile called "cgp_unioned" has been loaded into the database ---------------
--------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_folha_cgp()
  RETURNS TRIGGER AS
$BODY$
   BEGIN
       IF 
	     (SELECT st_intersects(NEW.geom, e.geom) from extent_cgp as e) = 'false' -- assumes shapefile, built from unioning all cgp polygons
	   THEN 
	     SELECT 'a0' INTO NEW.folha_cgp;
	   ELSE
       select cgp.div50 INTO NEW.folha_cgp from cgp where st_intersects(NEW.geom, cgp.geom) = 'true';
	   END IF;
       RETURN NEW;
   END;
$BODY$
   LANGUAGE 'plpgsql';
   
CREATE TRIGGER get_folha_cgp_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida  
  FOR each row
  EXECUTE PROCEDURE get_folha_cgp();
  
CREATE TRIGGER get_folha_cgp_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso 
  FOR each row
  EXECUTE PROCEDURE get_folha_cgp();

CREATE TRIGGER get_folha_cgp_incidente
  BEFORE INSERT OR UPDATE ON incidente  
  FOR each row
  EXECUTE PROCEDURE get_folha_cgp();
  
CREATE TRIGGER get_folha_cgp_geositio
  BEFORE INSERT OR UPDATE ON geositio 
  FOR each row
  EXECUTE PROCEDURE get_folha_cgp();
  
CREATE TRIGGER get_folha_cgp_intervencao
  BEFORE INSERT OR UPDATE ON intervencao
  FOR each row
  EXECUTE PROCEDURE get_folha_cgp();
  
-------------------------------------------------------------------------------------------------------------
-- Trigger function to update the municipo of table jazida, disperso, intervencao, geositio and incidente --- CHECKED!
----------------- (assumes the shapefile called "extent_municipios" has been loaded into the database ----------------
-------------------------------------------------------------------------------------------------------------
  
CREATE OR REPLACE FUNCTION get_municipio()
  RETURNS TRIGGER AS
$BODY$
   BEGIN
       IF 
	     (SELECT st_intersects(NEW.geom, p.geom) from extent_municipios as p) = 'false' -- assumes shapefile, built from unioning all CAOP polygons
	   THEN 
	     SELECT 0 INTO NEW.municipio;
	   ELSE
	     SELECT m.oid INTO NEW.municipio from municipio as m where st_intersects(st_centroid(NEW.geom), m.geom);
	END IF;
        RETURN NEW;
    END;
$BODY$
   LANGUAGE 'plpgsql';
   

CREATE TRIGGER get_municipio_into_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida  
  FOR each row
  EXECUTE PROCEDURE get_municipio();
  
CREATE TRIGGER get_municipio_into_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso  
  FOR each row
  EXECUTE PROCEDURE get_municipio();
  
CREATE TRIGGER get_municipio_into_intervencao
  BEFORE INSERT OR UPDATE ON intervencao  
  FOR each row
  EXECUTE PROCEDURE get_municipio();
  
  
-----------------------------------------------------------------------------------------------------------------
-- Trigger function to update the municipo_old of table jazida, disperso, intervencao, geositio and incidente --- CHECKED
----------------- (assumes the shapefile called "extent_municipios" has been loaded into the database --------------------
-----------------------------------------------------------------------------------------------------------------
  
CREATE OR REPLACE FUNCTION public.get_municipio_2011()
 RETURNS TRIGGER AS 
 $BODY$
   BEGIN
       IF 
	     (SELECT st_intersects(NEW.geom, p.geom) from extent_municipios as p) = 'false' -- assumes shapefile, built from unioning all CAOP polygons
	   THEN 
	     SELECT 0 INTO NEW.municipio_2011;
	   ELSE
	     SELECT m.oid INTO NEW.municipio_2011 from municipio_2011 as m where st_intersects(st_centroid(NEW.geom), m.geom);
	END IF;
        RETURN NEW;
    END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER get_municipio_2011_into_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida  
  FOR each row
  EXECUTE PROCEDURE get_municipio_2011();
  
CREATE TRIGGER get_municipio_2011_into_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso  
  FOR each row
  EXECUTE PROCEDURE get_municipio_2011();
  
CREATE TRIGGER get_municipio_2011_into_intervencao
  BEFORE INSERT OR UPDATE ON intervencao  
  FOR each row
  EXECUTE PROCEDURE get_municipio_2011();
  
CREATE TRIGGER get_municipio_2011_into_geositio
  BEFORE INSERT OR UPDATE ON geositio  
  FOR each row
  EXECUTE PROCEDURE get_municipio_2011();
  
CREATE TRIGGER get_municipio_2011_into_incidente
  BEFORE INSERT OR UPDATE ON incidente  
  FOR each row
  EXECUTE PROCEDURE get_municipio_2011();

  
-------------------------------------------------------------------------------------------------------------
-- Trigger function to update the geologia of table jazida, disperso, intervencao, geositio and incidente --- CHECKED!
-------------- (assumes the shapefile called "geologiaextent" has been loaded into the database -------------
-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_geologia()
  RETURNS TRIGGER AS
$BODY$
   BEGIN
       IF 
	     (SELECT st_intersects(NEW.geom, e.geom) from extent_geologia as e) = 'false' -- assumes shapefile, built from unioning all geologia polygons
	   THEN 
	     SELECT 0 INTO NEW.geologia_oid;
	   ELSE
	     SELECT g.oid INTO NEW.geologia_oid from geologia as g where st_intersects(NEW.geom, g.geom);
	   END IF;
       RETURN NEW;
    END;
$BODY$
   LANGUAGE 'plpgsql';
   
CREATE TRIGGER get_geologia_into_jazida -- CHECKED!
  BEFORE INSERT OR UPDATE ON jazida  
  FOR each row
  EXECUTE PROCEDURE get_geologia();
  
CREATE TRIGGER get_geologia_into_disperso -- CHECKED!
  BEFORE INSERT OR UPDATE ON disperso  
  FOR each row
  EXECUTE PROCEDURE get_geologia();
  
CREATE TRIGGER get_geologia_into_intervencao
  BEFORE INSERT OR UPDATE ON intervencao  
  FOR each row
  EXECUTE PROCEDURE get_geologia();;
  
CREATE TRIGGER get_geologia_into_geositio
  BEFORE INSERT OR UPDATE ON geositio  
  FOR each row
  EXECUTE PROCEDURE get_geologia();
  
CREATE TRIGGER get_geologia_into_incidente
  BEFORE INSERT OR UPDATE ON incidente  
  FOR each row
  EXECUTE PROCEDURE get_geologia();

--------------------------------------------------------------------------------------------------
-- Trigger function to update the taxon attribute, in table taxon, using the coalesce function --- CHECKED!
--------------------------------------------------------------------------------------------------
 
CREATE OR REPLACE FUNCTION get_taxon()
RETURNS TRIGGER LANGUAGE plpgsql AS
$BODY$
BEGIN
  NEW.taxon := coalesce(NEW.subespecie, NEW.especie, NEW.genero, NEW.subfamilia, 
                        NEW.familia, NEW.infraordem, NEW.subordem, NEW.ordem, NEW.superordem,
                        NEW.subclasse, NEW.classe, NEW.subphylum, NEW.phylum, NEW.reino);
  RETURN NEW;
END;
$BODY$ VOLATILE; 

CREATE TRIGGER update_taxon
    BEFORE INSERT OR UPDATE ON taxon
    FOR EACH ROW EXECUTE PROCEDURE get_taxon(); 


                                                --*********************************************************--
                                                --  IN TABLE HISTORY FUNCTIONS  IN TABLE HISTORY FUNCTIONS --                                    
                                                --*********************************************************--
            
			
---------------------------------------------------------
-- Trigger functions to update the history.taxon table  -- CHECKED!
---------------------------------------------------------


CREATE OR REPLACE FUNCTION taxon_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.taxon(operacao, data, tecnico, original_oid, taxon, reino, phylum, subphylum, classe, subclasse, superordem, ordem, subordem, infraordem, familia, subfamilia, genero, especie, subespecie)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.taxon, old.reino, old.phylum, old.subphylum, old.classe, old.subclasse, old.superordem, old.ordem, old.subordem, old.infraordem, old.familia, old.subfamilia, old.genero, old.especie, old.subespecie);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
/*
******* This trigger compromises the get_taxon trigger. The reasons are unclear but the get_taxon() trigger is more important, therefore, for the time being this function
******* and respective trigger are deactivated (08-Feb-2020)
*/
CREATE OR REPLACE FUNCTION taxon_history_update() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.taxon(operacao, data, tecnico, original_oid, taxon, reino, phylum, subphylum, classe, subclasse, superordem, ordem, subordem, infraordem, familia, subfamilia, genero, especie, subespecie)
		VALUES ('UPDATE', current_timestamp, current_user, new.oid, new.taxon, new.reino, new.phylum, new.subphylum, new.classe, new.subclasse, new.superordem, new.ordem, new.subordem, new.infraordem, new.familia, new.subfamilia, new.genero, new.especie, new.subespecie);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION taxon_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.taxon(operacao, data, tecnico, original_oid, taxon, reino, phylum, subphylum, classe, subclasse, superordem, ordem, subordem, infraordem, familia, subfamilia, genero, especie, subespecie)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.taxon, new.reino, new.phylum, new.subphylum, new.classe, new.subclasse, new.superordem, new.ordem, new.subordem, new.infraordem, new.familia, new.subfamilia, new.genero, new.especie, new.subespecie);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;


create TRIGGER taxon_history_delete
Before DELETE ON taxon
FOR EACH ROW EXECUTE PROCEDURE taxon_history_delete();

CREATE TRIGGER taxon_history_update
AFTER UPDATE ON taxon
FOR EACH ROW EXECUTE PROCEDURE taxon_history_update();

create TRIGGER taxon_history_insert
AFTER INSERT ON taxon
FOR EACH ROW EXECUTE PROCEDURE taxon_history_insert();

---------------------------------------------------------
-- Trigger function to update the history.risco table  -- UNCHECKED!
---------------------------------------------------------

CREATE OR REPLACE FUNCTION risco_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.risco(operacao, data, tecnico, original_oid, legenda, area_m2, geom, nivel)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.legenda, old.area_m2, old.geom, old.nivel);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION risco_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.risco(operacao, data, tecnico, original_oid, legenda, area_m2, geom, nivel)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.legenda, old.area_m2, old.geom, old.nivel);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION risco_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.risco(operacao, data, tecnico, original_oid, legenda, area_m2, geom, nivel)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.legenda, new.area_m2, new.geom, new.nivel);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_risco_delete
BEFORE DELETE ON risco
FOR EACH ROW EXECUTE PROCEDURE risco_history_delete();

CREATE TRIGGER history_risco_update
AFTER UPDATE ON risco
FOR EACH ROW EXECUTE PROCEDURE risco_history_update();

CREATE TRIGGER history_risco_insert
AFTER INSERT ON risco
FOR EACH ROW EXECUTE PROCEDURE risco_history_insert();

------------------------------------------------------------------
-- Trigger function to update the history.relatorio_prep table  -- UNCHECKED!
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION relatorio_prep_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.relatorio_prep(operacao, data, tecnico, original_oid, id_relatorio, preparador, data_abertura, data_conclusao, especimen)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.id_relatorio, old.preparador, old.data_abertura, old.data_conclusao, old.especimen);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;	
		
CREATE OR REPLACE FUNCTION relatorio_prep_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.relatorio_prep(operacao, data, tecnico, original_oid, id_relatorio, preparador, data_abertura, data_conclusao, especimen)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.id_relatorio, old.preparador, old.data_abertura, old.data_conclusao, old.especimen);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION relatorio_prep_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.relatorio_prep(operacao, data, tecnico, original_oid, id_relatorio, preparador, data_abertura, data_conclusao, especimen)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.id_relatorio, new.preparador, new.data_abertura, new.data_conclusao, new.especimen);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_relatorio_delete
BEFORE DELETE ON relatorio_prep
FOR EACH ROW EXECUTE PROCEDURE relatorio_prep_history_delete();

CREATE TRIGGER history_relatorio_update
AFTER UPDATE ON relatorio_prep
FOR EACH ROW EXECUTE PROCEDURE relatorio_prep_history_update();

CREATE TRIGGER history_relatorio_insert
AFTER INSERT ON relatorio_prep
FOR EACH ROW EXECUTE PROCEDURE relatorio_prep_history_insert();

---------------------------------------------------------------------
-- Trigger function to update the history.litoestratigrafia table  -- UNCHECKED!
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION litoestratigrafia_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.litoestratigrafia(operacao, data, tecnico, original_oid, pai, nome_completo, nivel, notas, nome)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.pai, old.nome_completo, old.nivel, old.notas, old.nome);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION litoestratigrafia_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.litoestratigrafia(operacao, data, tecnico, original_oid, pai, nome_completo, nivel, notas, nome)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.pai, old.nome_completo, old.nivel, old.notas, old.nome);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION litoestratigrafia_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.litoestratigrafia(operacao, data, tecnico, original_oid, pai, nome_completo, nivel, notas, nome)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.pai, new.nome_completo, new.nivel, new.notas, new.nome);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_litoestratigrafia_delete
BEFORE DELETE ON litoestratigrafia
FOR EACH ROW EXECUTE PROCEDURE litoestratigrafia_history_delete();

CREATE TRIGGER history_litoestratigrafia_update
AFTER UPDATE ON litoestratigrafia
FOR EACH ROW EXECUTE PROCEDURE litoestratigrafia_history_update();

CREATE TRIGGER history_litoestratigrafia_insert
AFTER INSERT  ON litoestratigrafia
FOR EACH ROW EXECUTE PROCEDURE litoestratigrafia_history_insert();

--------------------------------------------------------
-- Trigger function to update the history.jazida table  -- CHECKED!
--------------------------------------------------------

CREATE OR REPLACE FUNCTION jazida_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.jazida(operacao, data, tecnico, original_oid, in_situ, x_coor, y_coor, y_wgs84, x_wgs84, dop, num_satelites, cota, precisao, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.in_situ, old.x_coor, old.y_coor, old.y_wgs84, old.x_wgs84, old.dop, old.num_satelites, old.cota, old.precisao, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION jazida_history_update() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.jazida(operacao, data, tecnico, original_oid, in_situ, x_coor, y_coor, y_wgs84, x_wgs84, dop, num_satelites, cota, precisao, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.in_situ, old.x_coor, old.y_coor, old.y_wgs84, old.x_wgs84, old.dop, old.num_satelites, old.cota, old.precisao, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION jazida_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.jazida(operacao, data, tecnico, original_oid, in_situ, x_coor, y_coor, y_wgs84, x_wgs84, dop, num_satelites, cota, precisao, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.in_situ, new.x_coor, new.y_coor, new.y_wgs84, new.x_wgs84, new.dop, new.num_satelites, new.cota, new.precisao, new.geom);
	RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_jazida_delete
BEFORE DELETE ON jazida
FOR EACH ROW EXECUTE PROCEDURE jazida_history_delete();

CREATE TRIGGER history_jazida_update
AFTER UPDATE ON jazida
FOR EACH ROW EXECUTE PROCEDURE jazida_history_update();

CREATE TRIGGER history_jazida
AFTER INSERT ON jazida
FOR EACH ROW EXECUTE PROCEDURE jazida_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.geositio table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION geositio_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.geositio(operacao, data, tecnico, original_oid,acronimo, descricao, geologia_oid, municipio_2011, ortofoto_2004, folha_cmp, folha_cgp, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.acronimo, old.descricao, old.geologia_oid, old.municipio_2011, old.ortofoto_2004, old.folha_cmp, old.folha_cgp, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION geositio_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.geositio(operacao, data, tecnico, original_oid,acronimo, descricao, geologia_oid, municipio_2011, ortofoto_2004, folha_cmp, folha_cgp, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.acronimo, old.descricao, old.geologia_oid, old.municipio_2011, old.ortofoto_2004, old.folha_cmp, old.folha_cgp, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION geositio_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.geositio(operacao, data, tecnico, original_oid,acronimo, descricao, geologia_oid, municipio_2011, ortofoto_2004, folha_cmp, folha_cgp, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.acronimo, new.descricao, new.geologia_oid, new.municipio_2011, new.ortofoto_2004, new.folha_cmp, new.folha_cgp, new.geom);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_geositio_delete
BEFORE DELETE ON geositio
FOR EACH ROW EXECUTE PROCEDURE geositio_history_delete();

CREATE TRIGGER history_geositio_update
BEFORE UPDATE ON geositio
FOR EACH ROW EXECUTE PROCEDURE geositio_history_update();

CREATE TRIGGER history_geositio_insert
AFTER INSERT ON geositio
FOR EACH ROW EXECUTE PROCEDURE geositio_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.geologia table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION geologia_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.geologia(operacao, data, tecnico, original_oid,geologia, eon, era, periodo, epoca, idade, litologia, cod_lito, nomenclatura, area_m2, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.geologia, old.eon, old.era, old.periodo, old.epoca, old.idade, old.litologia, old.cod_lito, old.nomenclatura, old.area_m2, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION geologia_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.geologia(operacao, data, tecnico, original_oid,geologia, eon, era, periodo, epoca, idade, litologia, cod_lito, nomenclatura, area_m2, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.geologia, old.eon, old.era, old.periodo, old.epoca, old.idade, old.litologia, old.cod_lito, old.nomenclatura, old.area_m2, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION geologia_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.geologia(operacao, data, tecnico, original_oid,geologia, eon, era, periodo, epoca, idade, litologia, cod_lito, nomenclatura, area_m2, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.geologia, new.eon, new.era, new.periodo, new.epoca, new.idade, new.litologia, new.cod_lito, new.nomenclatura, new.area_m2, new.geom);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_geologia_delete
BEFORE DELETE ON geologia
FOR EACH ROW EXECUTE PROCEDURE geologia_history_delete();

CREATE TRIGGER history_geologia_update
AFTER UPDATE ON geologia
FOR EACH ROW EXECUTE PROCEDURE geologia_history_update();

CREATE TRIGGER history_geologia_insert
AFTER INSERT ON geologia
FOR EACH ROW EXECUTE PROCEDURE geologia_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.especimen table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION especimen_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.especimen(operacao, data, tecnico, original_oid, especimen, tipo_fossil, paleositio, taxon, elementos, material_associado, coleccao, proprietario, doaccao, doador, bacia, "sub-bacia", formacao, membro, bloco, caixa, loc_administrativa, obs, data_registo)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.especimen, old.tipo_fossil, old.paleositio, old.taxon, old.elementos, old.material_associado, old.coleccao, old.proprietario, old.doaccao, old.doador, old.bacia, old."sub-bacia", old.formacao, old.membro, old.bloco, old.caixa, old.loc_administrativa, old.obs, old.data_registo );
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
		
CREATE OR REPLACE FUNCTION especimen_history_update() RETURNS trigger AS 
$BODY$
BEGIN
INSERT INTO history.especimen(operacao, data, tecnico, original_oid, especimen, tipo_fossil, paleositio, taxon, elementos, material_associado, coleccao, proprietario, doaccao, doador, bacia, "sub-bacia", formacao, membro, bloco, caixa, loc_administrativa, obs, data_registo)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.especimen, old.tipo_fossil, old.paleositio, old.taxon, old.elementos, old.material_associado, old.coleccao, old.proprietario, old.doaccao, old.doador, old.bacia, old."sub-bacia", old.formacao, old.membro, old.bloco, old.caixa, old.loc_administrativa, old.obs, old.data_registo );		RETURN old;
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION especimen_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
INSERT INTO history.especimen(operacao, data, tecnico, original_oid, especimen, tipo_fossil, paleositio, taxon, elementos, material_associado, coleccao, proprietario, doaccao, doador, bacia, "sub-bacia", formacao, membro, bloco, caixa, loc_administrativa, obs, data_registo)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.especimen, new.tipo_fossil, new.paleositio, new.taxon, new.elementos, new.material_associado, new.coleccao, new.proprietario, new.doaccao, new.doador, new.bacia, new."sub-bacia", new.formacao, new.membro, new.bloco, new.caixa, new.loc_administrativa, new.obs, new.data_registo );		RETURN new;
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_especimen_delete
BEFORE DELETE ON especimen
FOR EACH ROW EXECUTE PROCEDURE especimen_history_delete();

CREATE TRIGGER history_especimen_update
AFTER UPDATE ON especimen
FOR EACH ROW EXECUTE PROCEDURE especimen_history_update();

CREATE TRIGGER history_especimen_insert
AFTER INSERT ON especimen
FOR EACH ROW EXECUTE PROCEDURE especimen_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.emprestimo table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION emprestimo_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.emprestimo(operacao, data, tecnico, original_oid,processo, instituicao, requerente, data_registo, data_devolucao, data_pedido, obs, devolucao)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.processo, old.instituicao, old.requerente, old.data_registo, old.data_devolucao, old.data_pedido, old.obs, old.devolucao);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION emprestimo_history_update() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.emprestimo(operacao, data, tecnico, original_oid,processo, instituicao, requerente, data_registo, data_devolucao, data_pedido, obs, devolucao)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.processo, old.instituicao, old.requerente, old.data_registo, old.data_devolucao, old.data_pedido, old.obs, old.devolucao);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION emprestimo_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.emprestimo(operacao, data, tecnico, original_oid,processo, instituicao, requerente, data_registo, data_devolucao, data_pedido, obs, devolucao)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.processo, new.instituicao, new.requerente, new.data_registo, new.data_devolucao, new.data_pedido, new.obs, new.devolucao);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_emprestimo_delete
BEFORE DELETE ON emprestimo
FOR EACH ROW EXECUTE PROCEDURE emprestimo_history_delete();

CREATE TRIGGER history_emprestimo_update
AFTER UPDATE ON emprestimo
FOR EACH ROW EXECUTE PROCEDURE emprestimo_history_update();

CREATE TRIGGER history_emprestimo_insert
AFTER INSERT ON emprestimo
FOR EACH ROW EXECUTE PROCEDURE emprestimo_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.disperso table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION disperso_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.disperso(operacao, data, tecnico, original_oid,x_wgs84_centroid, y_wgs84_centroid, x_coor_centroid, y_coor_centroid, area_m2, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.x_wgs84_centroid, old.y_wgs84_centroid, old.x_coor_centroid, old.y_coor_centroid, old.area_m2, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;	

CREATE OR REPLACE FUNCTION disperso_history_update() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.disperso(operacao, data, tecnico, original_oid,x_wgs84_centroid, y_wgs84_centroid, x_coor_centroid, y_coor_centroid, area_m2, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.x_wgs84_centroid, old.y_wgs84_centroid, old.x_coor_centroid, old.y_coor_centroid, old.area_m2, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION disperso_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.disperso(operacao, data, tecnico, original_oid,x_wgs84_centroid, y_wgs84_centroid, x_coor_centroid, y_coor_centroid, area_m2, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.x_wgs84_centroid, new.y_wgs84_centroid, new.x_coor_centroid, new.y_coor_centroid, new.area_m2, new.geom);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_disperso_delete
BEFORE DELETE ON disperso
FOR EACH ROW EXECUTE PROCEDURE disperso_history_delete();

CREATE TRIGGER history_disperso_update
AFTER UPDATE ON disperso
FOR EACH ROW EXECUTE PROCEDURE disperso_history_update();

CREATE TRIGGER history_disperso_insert
AFTER INSERT ON disperso
FOR EACH ROW EXECUTE PROCEDURE disperso_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.paleositio table  -- CHECKED!
---------------------------------------------------------- 
  
CREATE OR REPLACE FUNCTION paleositio_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.paleositio(operacao, data, tecnico, original_oid, acronimo, acronimo_old, especies, geologia_oid, matriz, fotos, toponimo, data_registo, equipa, obs, translado, risco, municipio_2011, municipio, litoestratigrafia_oid, ortofoto_2004, folha_cmp, folha_cgp)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.acronimo, old.acronimo_old, old.especies, old.geologia_oid, old.matriz, old.fotos, old.toponimo, old.data_registo, old.equipa, old.obs, old.translado, old.risco, old.municipio_2011, old.municipio, old.litoestratigrafia_oid, old.ortofoto_2004, old.folha_cmp, old.folha_cgp);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION paleositio_history_update() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.paleositio(operacao, data, tecnico, original_oid, acronimo, acronimo_old, especies, geologia_oid, matriz, fotos, toponimo, data_registo, equipa, obs, translado, risco, municipio_2011, municipio, litoestratigrafia_oid, ortofoto_2004, folha_cmp, folha_cgp)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.acronimo, old.acronimo_old, old.especies, old.geologia_oid, old.matriz, old.fotos, old.toponimo, old.data_registo, old.equipa, old.obs, old.translado, old.risco, old.municipio_2011, old.municipio, old.litoestratigrafia_oid, old.ortofoto_2004, old.folha_cmp, old.folha_cgp);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION paleositio_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.paleositio(operacao, data, tecnico, original_oid, acronimo, acronimo_old, especies, geologia_oid, matriz, toponimo, data_registo, equipa, obs, translado, risco, municipio_2011, municipio, litoestratigrafia_oid, ortofoto_2004, folha_cmp, folha_cgp)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.acronimo, new.acronimo_old, new.especies, new.geologia_oid, new.matriz, new.fotos, new.toponimo, new.data_registo, new.equipa, new.obs, new.translado, new.risco, new.municipio_new, new.municipio, new.litoestratigrafia_oid, new.ortofoto_2004, new.folha_cmp, new.folha_cgp);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_paleositio_delete
BEFORE DELETE ON paleositio
FOR EACH ROW EXECUTE PROCEDURE paleositio_history_delete();

CREATE TRIGGER history_paleositio_update
AFTER UPDATE  ON paleositio
FOR EACH ROW EXECUTE PROCEDURE paleositio_history_update();

CREATE TRIGGER history_paleositio_insert
AFTER INSERT ON paleositio
FOR EACH ROW EXECUTE PROCEDURE paleositio_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.incidente table  -- CHECKED!
---------------------------------------------------------- 

CREATE OR REPLACE FUNCTION incidente_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.incidente(operacao, data, tecnico, original_oid, codigo, descricao, contacto, data_ocorrencia, data_registo, ortofoto_2004, folha_cgp, folha_cmp, geologia_oid, municipio_2011, risco, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.codigo, old.descricao, old.contacto, old.data_ocorrencia, old.data_registo, old.ortofoto_2004, old.folha_cgp, old.folha_cmp, old.geologia_oid, old.municipio_2011, old.risco, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;	

CREATE OR REPLACE FUNCTION incidente_history_update() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.incidente(operacao, data, tecnico, original_oid, codigo, descricao, contacto, data_ocorrencia, data_registo, ortofoto_2004, folha_cgp, folha_cmp, geologia_oid, municipio_2011, risco, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.codigo, old.descricao, old.contacto, old.data_ocorrencia, old.data_registo, old.ortofoto_2004, old.folha_cgp, old.folha_cmp, old.geologia_oid, old.municipio_2011, old.risco, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION incidente_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.incidente(operacao, data, tecnico, original_oid, codigo, descricao, contacto, data_ocorrencia, data_registo, ortofoto_2004, folha_cgp, folha_cmp, geologia_oid, municipio_2011, risco, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.codigo, new.descricao, new.contacto, new.data_ocorrencia, new.data_registo, new.ortofoto_2004, new.folha_cgp, new.folha_cmp, new.geologia_oid, new.municipio_2011, new.risco, new.geom);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_incidente_delete
BEFORE DELETE ON incidente
FOR EACH ROW EXECUTE PROCEDURE incidente_history_delete();

CREATE TRIGGER history_incidente_update
AFTER UPDATE  ON incidente
FOR EACH ROW EXECUTE PROCEDURE incidente_history_update();

CREATE TRIGGER history_incidente_insert
AFTER INSERT ON incidente
FOR EACH ROW EXECUTE PROCEDURE incidente_history_insert();

----------------------------------------------------------
-- Trigger function to update the history.intervencao table  -- CHECKED!
----------------------------------------------------------  
  
CREATE OR REPLACE FUNCTION intervencao_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.intervencao(operacao, data, tecnico, original_oid, codigo, tipo_interv, data_inicio, data_fim, relatorio_interv, municipio, municipio_2011, folha_cgp, folha_cmp, ortofoto_2004, geologia_oid, geom)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.codigo, old.tipo_interv, old.data_inicio, old.data_fim, old.relatorio_interv, old.municipio, old.municipio_2011, old.folha_cgp, old.folha_cmp, old.ortofoto_2004, old.geologia_oid, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION intervencao_history_update() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.intervencao(operacao, data, tecnico, original_oid, codigo, tipo_interv, data_inicio, data_fim, relatorio_interv, municipio, municipio_2011, folha_cgp, folha_cmp, ortofoto_2004, geologia_oid, geom)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.codigo, old.tipo_interv, old.data_inicio, old.data_fim, old.relatorio_interv, old.municipio, old.municipio_2011, old.folha_cgp, old.folha_cmp, old.ortofoto_2004, old.geologia_oid, old.geom);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION intervencao_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.intervencao(operacao, data, tecnico, original_oid, codigo, tipo_interv, data_inicio, data_fim, relatorio_interv, municipio, municipio_2011, folha_cgp, folha_cmp, ortofoto_2004, geologia_oid, geom)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.codigo, new.tipo_interv, new.data_inicio, new.data_fim, new.relatorio_interv, new.municipio, new.municipio_2011, new.folha_cgp, new.folha_cmp, new.ortofoto_2004, new.geologia_oid, new.geom);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_intervencao_delete
BEFORE DELETE ON intervencao
FOR EACH ROW EXECUTE PROCEDURE intervencao_history_delete();

CREATE TRIGGER history_intervencao_update
AFTER UPDATE ON intervencao
FOR EACH ROW EXECUTE PROCEDURE intervencao_history_update();

CREATE TRIGGER history_intervencao_insert
AFTER INSERT ON intervencao
FOR EACH ROW EXECUTE PROCEDURE intervencao_history_insert();


----------------------------------------------------------
-- Trigger function to update the history.inventario table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION inventario_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.inventario(operacao, data, tecnico, original_oid, peca, fragmento, especimen, observacoes, elem_osteologico)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.peca, old.fragmento, old.especimen, old.observacoes, old.elem_osteologico);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;
	
CREATE OR REPLACE FUNCTION inventario_history_update() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.inventario(operacao, data, tecnico, original_oid, peca, fragmento, especimen, observacoes, elem_osteologico)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.peca, old.fragmento, old.especimen, old.observacoes, old.elem_osteologico);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION inventario_history_insert() RETURNS trigger AS 
$BODY$
BEGIN
        INSERT INTO history.inventario(operacao, data, tecnico, original_oid, peca, fragmento, especimen, observacoes, elem_osteologico)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.peca, new.fragmento, new.especimen, new.observacoes, new.elem_osteologico);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_inventario_delete
BEFORE DELETE ON inventario
FOR EACH ROW EXECUTE PROCEDURE inventario_history_delete();

CREATE TRIGGER history_inventario_update
AFTER UPDATE ON inventario
FOR EACH ROW EXECUTE PROCEDURE inventario_history_update();

CREATE TRIGGER history_inventario_insert
AFTER INSERT ON inventario
FOR EACH ROW EXECUTE PROCEDURE inventario_history_insert();

/*  
----------------------------------------------------------
-- Trigger function to update the history.fotografia table  -- NOT CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION fotografia_history_delete() RETURNS trigger AS 
$BODY$
BEGIN
		INSERT INTO history.fotografia(operacao, data, tecnico, oid, photo_number, paleositio, geositio, especimen, incidente, intervencao, intervencao, inventario, tipo_fotografia, diretoria, image_size, megapixels, file_size, camera, date, exif_height, exif_widht, exposure_time, aperture, iso)
		VALUES ('DELETE', current_timestamp, current_user, old.oid, old.photo_number, old.paleositio, old.geositio, old.especimen, old.incidente, old.intervencao, old.intervencao, old.inventario, old.tipo_fotografia, old.diretoria, old.image_size, old.megapixels, old.file_size, old.camera, old.date, old.exif_height, old.exif_widht, old.exposure_time, old.aperture, old.iso);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fotografia_history_update() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.fotografia(operacao, data, tecnico, oid, photo_number, paleositio, geositio, especimen, incidente, intervencao, intervencao, inventario, tipo_fotografia, diretoria, image_size, megapixels, file_size, camera, date, exif_height, exif_widht, exposure_time, aperture, iso)
		VALUES ('UPDATE', current_timestamp, current_user, old.oid, old.photo_number, old.paleositio, old.geositio, old.especimen, old.incidente, old.intervencao, old.intervencao, old.inventario, old.tipo_fotografia, old.diretoria, old.image_size, old.megapixels, old.file_size, old.camera, old.date, old.exif_height, old.exif_widht, old.exposure_time, old.aperture, old.iso);
		RETURN old;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fotografia_history_insert() RETURNS trigger AS 
$BODY$
BEGIN	
		INSERT INTO history.fotografia(operacao, data, tecnico, oid, photo_number, paleositio, geositio, especimen, incidente, intervencao, intervencao, inventario, tipo_fotografia, diretoria, image_size, megapixels, file_size, camera, date, exif_height, exif_widht, exposure_time, aperture, iso)
		VALUES ('INSERT', current_timestamp, current_user, new.oid, new.photo_number, new.paleositio, new.geositio, new.especimen, new.incidente, new.intervencao, new.intervencao, new.inventario, new.tipo_fotografia, new.diretoria, new.image_size, new.megapixels, new.file_size, new.camera, new.date, new.exif_height, new.exif_widht, new.exposure_time, new.aperture, new.iso);
		RETURN new;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER history_fotografia_delete
BEFORE DELETE ON fotografia
FOR EACH ROW EXECUTE PROCEDURE fotografia_history_delete();

CREATE TRIGGER history_fotografia_update
BEFORE UPDATE  ON fotografia
FOR EACH ROW EXECUTE PROCEDURE fotografia_history_update();

CREATE TRIGGER history_fotografia_insert
AFTER INSERT ON fotografia
FOR EACH ROW EXECUTE PROCEDURE fotografia_history_insert();
*/

----------------------------------------------------------
-- Trigger function to update the lista_acronimos table  -- CHECKED!
----------------------------------------------------------

CREATE OR REPLACE FUNCTION insert_into_lista_acronimos()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if NEW.acronimo starts with 'acronimo'
    IF LEFT(NEW.acronimo, 8) != 'acronimo' THEN
        -- If it does not start with 'acronimo', insert it into the table
        INSERT INTO lista_acronimos(acronimo)
        VALUES (NEW.acronimo);
    END IF;

    -- Allow the original operation to proceed
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER lista_acronimos_jazida_insert
AFTER INSERT ON jazida
FOR EACH ROW EXECUTE PROCEDURE insert_into_lista_acronimos();

CREATE TRIGGER lista_acronimos_disperso_insert
AFTER INSERT ON disperso
FOR EACH ROW EXECUTE PROCEDURE insert_into_lista_acronimos();


												--**********************
                                                --  VIEWS DEFINITIONS --                                    
                                                --**********************

--------------------------------------------------------------------------------
-- Junction table view: equipa_consituem_tecnico  -- CHECKED!
--------------------------------------------------------------------------------

CREATE VIEW equipa_constituem_tecnico AS
WITH equipa_constituem_tecnico as
	(SELECT generate_series(1, (SELECT count(*) FROM equipa)) as oid_equipa,
		   generate_series(1, (SELECT count(*) FROM tecnico)) as oid_tecnico)

		
		
		SELECT t.nome, e.designacao
		FROM tecnico AS t 
			JOIN equipa_constituem_tecnico AS c ON t.oid = c.oid_tecnico
			JOIN equipa AS e ON e.oid = c.oid_equipa;
		
		/* With juntion table view it is now easy to know to what teams did a person contributed --
		SELECT *
		FROM equipa_consituem_tecnico
		WHERE designacao LIKE '%'||iniciais||'%' AND t.apelido = 'Piteira' -- check teams where Bruno Piteira participated
		*/ 
		
--------------------------------------------------------------------------------
-- Junction table view: especimen_referido_publicacao  -- CHECKED!
--------------------------------------------------------------------------------

CREATE VIEW especimen_referido_publicacao AS
	SELECT generate_series(1, (SELECT count(*) FROM especimen)) as oid_especimen,
		   generate_series(1, (SELECT count(*) FROM publicacao)) as oid_publicacao;

--------------------------------------------------------------------------------
-- Junction table view: paleositio_contem_taxon  -- CHECKED!
--------------------------------------------------------------------------------

CREATE VIEW paleositio_contem_taxon  AS
	SELECT generate_series(1, (SELECT count(*) FROM paleositio)) as oid_paleositio,
		   generate_series(1, (SELECT count(*) FROM especimen)) as oid_especimen;
		   
--------------------------------------------------------------------------------
-- Junction table view: relatorio_prep_redige_tecnico  -- CHECKED!
--------------------------------------------------------------------------------

CREATE VIEW relatorio_prep_redige_tecnico AS
	SELECT generate_series(1, (SELECT count(*) FROM relatorio_prep)) as oid_relatorio_prep,
		   generate_series(1, (SELECT count(*) FROM tecnico)) as oid_tecnico;

------------------------------------------------------
-- Jazida view for web map client for researchers --
------------------------------------------------------

CREATE VIEW jazidas AS
(SELECT j.acronimo, 
       j.acronimo_old,
	    g.idade as geologia,
	   j.matriz,
	   j.toponimo,
	   j.vestigios,
	   j.especies,
	   j.in_situ,
	   j.data_registo,
	   j.equipa,
	   j.obs,
	   j.translado,
	   j.ortofoto_2004,
	   m.freguesia as municipio, 
       m2011.freguesia as municipio_2011, 
	   cgp.div50 as cgp, 
	   cmp.nfolha as cmp,
	   j.x_coor,
	   j.y_coor,
	   j.x_wgs84,
	   j.y_wgs84,
	   j.cota,
	   j.precisao,
	   j.geom
FROM jazida AS j LEFT JOIN municipio AS m ON m.oid = j.municipio
			     LEFT JOIN municipio_2011 as m2011 ON m2011.oid = j.municipio_2011
				 LEFT JOIN cgp ON cgp.div50 = j.folha_cgp
				 LEFT JOIN cmp ON cmp.nfolha = j.folha_cmp
				 LEFT JOIN geologia as g on g.oid = j.geologia_oid);
	   
	   
---------------------------------------------------------
-- Jazida view for web map client for general public --
---------------------------------------------------------

CREATE VIEW jazidas_public AS 
(SELECT j.acronimo, 
	   g.idade as geologia,
	   j.matriz,
	   j.vestigios,
	   j.especies,
	   j.data_registo,
       m2011.freguesia as municipio_2011, 
	   j.geom
FROM jazida AS j LEFT JOIN municipio_2011 AS m2011 ON m2011.oid = j.municipio_2011
				 LEFT JOIN geologia as g on g.oid = j.geologia_oid);

------------------------------------------------------
-- Disperso view for web map client for researchers --
------------------------------------------------------

CREATE VIEW dispersos AS
(SELECT d.acronimo, 
       d.acronimo_old,
	    g.idade as geologia,
	   d.matriz,
	   d.toponimo,
	   d.vestigios,
	   d.especies,
	   d.data_registo,
	   d.equipa,
	   d.obs,
	   d.translado,
	   d.ortofoto_2004,
	   m.freguesia as municipio, 
       m2011.freguesia as municipio_2011, 
	   cgp.div50 as cgp, 
	   cmp.nfolha as cmp,
	   d.x_coor_centroid,
	   d.y_coor_centroid,
	   d.x_wgs84_centroid,
	   d.y_wgs84_centroid,
	   d.area_m2,
	   d.geom
FROM disperso AS d LEFT JOIN municipio AS m ON m.oid = d.municipio
			     LEFT JOIN municipio_2011 as m2011 ON m2011.oid = d.municipio_2011
				 LEFT JOIN cgp ON cgp.div50 = d.folha_cgp
				 LEFT JOIN cmp ON cmp.nfolha = d.folha_cmp
				 LEFT JOIN geologia as g on g.oid = d.geologia_oid);

---------------------------------------------------------
-- Disperso view for web map client for general public --
---------------------------------------------------------

CREATE VIEW dispersos_public AS 
(SELECT d.acronimo, 
	   g.idade as geologia,
	   d.matriz,
	   d.vestigios,
	   d.especies,
	   d.data_registo,
       m2011.freguesia as municipio_2011, 
	   d.geom
FROM disperso AS d LEFT JOIN municipio_2011 AS m2011 ON m2011.oid = d.municipio_2011
				 LEFT JOIN geologia as g on g.oid = d.geologia_oid);
				 
---------------------------------------------------------
-- Fotografia view for web map client for researchers ---
---------------------------------------------------------

create view foto_webmap as (
SELECT oid, paleositio, source_file as fotografia, image_size as dimensao, date as data
from fotografia);


											--***********************************************************--
											-- OVERVIEW VIEWS TO GENERATE PLOTS IN LIZMAP OR OTHER TOOLS --
											--***********************************************************--


------------------------------
-- create dedicated schemma --
------------------------------

CREATE SCHEMA lizmapviews;

--------------------------
-- jazidas by freguesia --
--------------------------

CREATE MATERIALIZED VIEW lizmapviews.jazidas_freguesia AS
(SELECT row_number() over() as id,
		count(j.*), 
		m.freguesia, 
		m.municipio
FROM jazida AS j, municipio_2011 as m
WHERE st_intersects(j.geom, m.geom)
GROUP BY m.freguesia,
		 m.municipio);


CREATE OR REPLACE FUNCTION refresh_jazidas_freguesia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.jazidas_freguesia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER jazidas_freguesia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazidas_freguesia_view();

CREATE TRIGGER jazidas_freguesia_2
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazidas_freguesia_view();


---------------------------
-- disperso by freguesia --
---------------------------

CREATE materialized view lizmapviews.disperso_freguesia AS
(SELECT row_number() over() as id,
		count(d.*), 
		m.freguesia, 
		m.municipio
FROM disperso AS d, municipio_2011 as m
WHERE st_intersects(st_centroid(d.geom), m.geom)
GROUP BY m.freguesia,
		 m.municipio);
		 

CREATE OR REPLACE FUNCTION refresh_disperso_freguesia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.disperso_freguesia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER disperso_freguesia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_freguesia_view();

CREATE TRIGGER disperso_freguesia_2
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_freguesia_view();

	
-----------------------------
-- paleositio by freguesia --
-----------------------------

CREATE MATERIALIZED VIEW lizmapviews.paleositio_freguesia AS
(WITH paleositio AS
(SELECT oid, 
		geom
FROM jazida
		UNION
SELECT 
	oid, 
	st_centroid(geom) as geom
FROM disperso)

SELECT row_number() over() as id,
	   count(p.*), 
	   m.freguesia, 
	   m.municipio
FROM paleositio as p, municipio_2011 as m
WHERE st_intersects(p.geom, m.geom)
GROUP BY m.freguesia, 
		 m.municipio);
		 
		 
CREATE OR REPLACE FUNCTION refresh_paleositio_freguesia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.paleositio_freguesia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER paleositio_freguesia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_freguesia_view();

CREATE TRIGGER paleositio_freguesia_2
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_freguesia_view();


------------------------
-- jazida by geologia --
------------------------

CREATE materialized VIEW lizmapviews.jazidas_geologia AS
(SELECT row_number() over() as id,
		count(j.*), 
		g.periodo, 
		g.idade
FROM jazida AS j, geologia as g
WHERE st_intersects(j.geom, g.geom)
GROUP BY g.periodo, 
		 g.idade);


CREATE OR REPLACE FUNCTION refresh_jazida_geologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.jazidas_geologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER jazida_geologia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_geologia_view();

CREATE TRIGGER jazida_geologia_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_geologia_view();


---------------------------
-- litologia by geologia --
---------------------------		 
		 
CREATE materialized VIEW lizmapviews.jazidas_litologia AS
(SELECT row_number() over() as id,
		count(j.*), 
		g.litologia
FROM jazida AS j, geologia as g
WHERE st_intersects(j.geom, g.geom)
GROUP BY g.litologia);


CREATE OR REPLACE FUNCTION refresh_jazidas_litologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.jazidas_litologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER jazida_litologia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazidas_litologia_view();

CREATE TRIGGER jazida_litologia_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazidas_litologia_view();


--------------------------
-- disperso by geologia --
--------------------------

CREATE materialized VIEW lizmapviews.disperso_geologia AS
(SELECT row_number() over() as id,
		count(d.*), 
		g.periodo, 
		g.idade
FROM disperso AS d, geologia as g
WHERE st_intersects(d.geom, g.geom)
GROUP BY g.periodo, 
		 g.idade);


CREATE OR REPLACE FUNCTION refresh_disperso_geologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.disperso_geologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER disperso_geologia_3
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_litologia_view();

CREATE TRIGGER disperso_geologia_4
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_litologia_view();


---------------------------
-- disperso by litologia --
---------------------------
		 
CREATE materialized VIEW lizmapviews.disperso_litologia AS
(SELECT row_number() over() as id,
		count(d.*), 
		g.litologia
FROM disperso AS d, geologia as g
WHERE st_intersects(d.geom, g.geom)
GROUP BY g.litologia);


CREATE OR REPLACE FUNCTION refresh_disperso_litologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.disperso_litologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER disperso_geologia_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_litologia_view();

CREATE TRIGGER disperso_geologia_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_disperso_litologia_view();


----------------------------
-- paleositio by geologia --
----------------------------

CREATE MATERIALIZED VIEW lizmapviews.paleositio_geologia AS
(WITH paleositio AS
(SELECT oid, 
		geom
FROM jazida
		UNION
SELECT 
	oid, 
	st_centroid(geom) as geom
FROM disperso)

SELECT 
    row_number() over() as id,
	count(p.*), 
	g.periodo, 
	g.idade 
FROM paleositio as p, geologia as g
WHERE st_intersects(p.geom, g.geom)
GROUP BY g.periodo, 
		 g.idade);
		 

CREATE OR REPLACE FUNCTION refresh_paleositio_geologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.paleositio_geologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER paleositio_geologia_1
AFTER INSERT OR UPDATE OR DELETE ON paleositio
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_geologia_view();

CREATE TRIGGER paleositio_geologia_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_geologia_view();


-----------------------------
-- paleositio by litologia --
-----------------------------

CREATE MATERIALIZED VIEW lizmapviews.paleositio_litologia AS
(WITH paleositio AS
(SELECT oid, 
		geom
FROM jazida
		UNION
SELECT 
	oid, 
	st_centroid(geom) as geom
FROM disperso)

SELECT 
    row_number() over() as id,
	count(p.*),  
	g.litologia 
FROM paleositio as p, geologia as g
WHERE st_intersects(p.geom, g.geom)
GROUP BY litologia);


CREATE OR REPLACE FUNCTION refresh_paleositio_litologia_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.paleositio_litologia;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER paleositio_litologia_1
AFTER INSERT OR UPDATE OR DELETE ON paleositio
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_geologia_view();

CREATE TRIGGER paleositio_litologia_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_geologia_view();


---------------------------
-- especies in paleositio -
---------------------------

Create materialized view lizmapviews.paleositio_especies as
(with filtered as
(select trim(s.especies) as especies, count(*)
from paleositio AS j
     cross join unnest(string_to_array(j.especies, ',')) AS s (especies)
where s.especies not ilike '%;%'
group by s.especies 

union

select trim(s.especies) as especies, count(*)
from paleositio AS j
     cross join unnest(string_to_array(j.especies, ';')) AS s (especies)
where s.especies not ilike '%,%'
group by s.especies)

 select row_number() over() as id, sum(f.count), especies
 from filtered as f
 group by especies);


CREATE OR REPLACE FUNCTION refresh_paleositio_especies_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.paleositio_especies;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER paleositio_especies
AFTER INSERT OR UPDATE OR DELETE ON paleositio
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_especies_view();


----------------------------
-- vestigios in paleositio -
----------------------------


Create materialized view lizmapviews.paleositio_vestigios as
(with filtered as
(select trim(s.vestigios) as vestigios, count(*)
from paleositio AS j
     cross join unnest(string_to_array(j.vestigios, ',')) AS s (vestigios)
where s.vestigios not ilike '%;%'
group by s.vestigios 

union

select trim(s.vestigios) as especies, count(*)
from paleositio AS j
     cross join unnest(string_to_array(j.vestigios, ';')) AS s (vestigios)
where s.vestigios not ilike '%,%'
group by s.vestigios)

 select row_number() over() as id, sum(f.count), vestigios
 from filtered as f
 where vestigios is not null or vestigios =''
 group by vestigios);
 
 CREATE OR REPLACE FUNCTION refresh_paleositio_vestigios_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lizmapviews.paleositio_vestigios;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER paleositio_vestigios
AFTER INSERT OR UPDATE OR DELETE ON paleositio
FOR EACH STATEMENT EXECUTE FUNCTION refresh_paleositio_vestigios_view();
 
 
---------------------------------------------------------------------------------------------------------------------------------
-- CREATE MATERILIZED VIEW FOR listagem_jazida AND MAINTENANCE TRIGGERS (convenient for generating tables to share outside SHN) -
---------------------------------------------------------------------------------------------------------------------------------
 
CREATE MATERIALIZED VIEW listagem_jazida as
SELECT j.acronimo, 
       j.matriz, 
	   j.especies, 
	   j.vestigios, 
	   j.folha_cmp, 
	   j.folha_cgp,  
	   g.periodo, 
	   g.epoca, 
	   g.idade, 
	   g.litologia, 
	   g.cod_lito, 
	   j.toponimo,
	   m.freguesia,
	   m.municipio,
	   j.obs as observacoes, 
	   j.geom
FROM jazida AS j JOIN geologia AS g ON j.geologia_oid = g.oid
                 JOIN municipio_2011 AS m ON j.municipio_2011 = m.oid;
				 
 
CREATE OR REPLACE FUNCTION refresh_listagem_jazida_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW listagem_jazida;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER listagem_jazida_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER listagem_jazida_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER listagem_jazida_3
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

------------------------------------------------------------------------ 
-- CREATE MATERILIZED VIEW FOR jazida_websiga AND MAINTENANCE TRIGGERS -
------------------------------------------------------------------------

CREATE MATERIALIZED VIEW jazida_websigap as
SELECT j.acronimo, 
       j.matriz, 
	   j.especies, 
	   j.vestigios,
	   j.data_registo,
	   j.equipa,
	   j.dop,
	   j.num_satelites,
	   j.cota,
	   j.precisao,
	   j.translado,
	   j.risco,
	   j.ortofoto_2004,   
	   j.folha_cmp, 
	   j.folha_cgp,  
	   g.periodo, 
	   g.epoca, 
	   g.idade, 
	   g.litologia, 
	   g.cod_lito, 
	   j.toponimo,
	   m.freguesia,
	   m.municipio,
	   j.obs as observacoes, 
	   j.geom
FROM jazida AS j JOIN geologia AS g ON j.geologia_oid = g.oid
                 JOIN municipio_2011 AS m ON j.municipio_2011 = m.oid;
 
-------------------------------------------------------------------------
-- CREATE MATERILIZED VIEW FOR jazida_websigap AND MAINTENANCE TRIGGERS -
-------------------------------------------------------------------------

CREATE MATERIALIZED VIEW jazida_websigap as
SELECT j.oid,
       j.acronimo, 
       j.matriz, 
	   j.especies, 
	   j.vestigios,
	   j.in_situ,
	   j.data_registo,
	   j.equipa,
	   j.x_coor,
	   j.y_coor,
	   j.x_wgs84,
	   j.y_wgs84,
	   j.dop,
	   j.num_satelites,
	   j.cota,
	   j.precisao,
	   j.translado,
	   j.risco,
	   j.ortofoto_2004,   
	   j.folha_cmp, 
	   j.folha_cgp,  
	   g.periodo, 
	   g.epoca, 
	   g.idade, 
	   g.litologia, 
	   g.cod_lito, 
	   j.toponimo,
	   m.freguesia,
	   m.municipio,
	   j.obs as observacoes, 
	   j.geom
FROM jazida AS j JOIN geologia AS g ON j.geologia_oid = g.oid
                 JOIN municipio_2011 AS m ON j.municipio_2011 = m.oid;
				 

CREATE OR REPLACE FUNCTION refresh_jazida_websigap_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW jazida_websigap;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER jazida_websigap_1
AFTER INSERT OR UPDATE OR DELETE ON jazida
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER jazida_websigap_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER jazida_websigap_3
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

---------------------------------------------------------------------------
-- CREATE MATERILIZED VIEW FOR disperso_websigap AND MAINTENANCE TRIGGERS -
---------------------------------------------------------------------------

CREATE MATERIALIZED VIEW disperso_websigap as
SELECT d.oid,
	   d.acronimo,
       d.matriz,
	   d.especies,  
	   d.vestigios,
	   d.data_registo,
	   d.equipa,
	   d.x_coor_centroid,
	   d.y_coor_centroid,
	   d.x_wgs84_centroid,
	   d.y_wgs84_centroid,
	   d.area_m2,
	   d.translado,
	   d.risco,
	   d.ortofoto_2004, 
	   d.folha_cmp,
	   d.folha_cgp,
	   g.periodo,
	   g.epoca,
	   g.idade,
	   g.litologia,
	   g.cod_lito,
	   d.toponimo,
	   m.freguesia,
	   m.municipio,
	   d.obs as observacoes,
	   d.geom
FROM disperso AS d JOIN geologia AS g ON d.geologia_oid = g.oid
                 JOIN municipio_2011 AS m ON d.municipio_2011 = m.oid;


CREATE OR REPLACE FUNCTION refresh_disperso_websigap_view() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW disperso_websigap;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER disperso_websigap_1
AFTER INSERT OR UPDATE OR DELETE ON disperso
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER disperso_websigap_2
AFTER INSERT OR UPDATE OR DELETE ON geologia
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();

CREATE TRIGGER disperso_websigap_3
AFTER INSERT OR UPDATE OR DELETE ON municipio_2011
FOR EACH STATEMENT EXECUTE FUNCTION refresh_jazida_websigap_view();


end;
