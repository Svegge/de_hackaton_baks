create schema if not exists dds;

-- drop table if exists dds.d_timestamps cascade;
-- drop table if exists dds.d_referer cascade;
-- drop table if exists dds.d_page_url cascade;
-- drop table if exists dds.d_user_domain cascade;
-- drop table if exists dds.f_events cascade;

--d_timestamps
create table if not exists dds.d_timestamps (
	 id serial not null primary key
	,ts timestamp
	,year integer
	,month integer
	,day integer
	,hour integer
	,minute integer
	,second integer
);

--d_referer
create table if not exists dds.d_referer (
	 id serial not null primary key
	,referer_url varchar(500)
	,referer_medium varchar(30)
);

--d_page_url
create table if not exists dds.d_page_url (
	 id serial not null primary key
	,page_url_path varchar(100)
);

--d_user_domain
create table if not exists dds.d_user_domain (
	 id serial not null primary key
	,user_domain_id varchar(100)
);

--f_events
create table if not exists dds.f_events (
	 event_id varchar not null primary key
	,timestamp_id integer 
	,referer_id integer 
	,page_url_id integer 
	,domain_id integer
);

ALTER TABLE dds.f_events DROP CONSTRAINT IF EXISTS f_clicks_d_timestamps_id_fkey;
alter table dds.f_events add constraint f_clicks_d_timestamps_id_fkey foreign key (timestamp_id) references dds.d_timestamps (id);
ALTER TABLE dds.f_events DROP CONSTRAINT IF EXISTS f_clicks_d_referer_id_fkey;
alter table dds.f_events add constraint f_clicks_d_referer_id_fkey foreign key (referer_id) references dds.d_referer (id);
ALTER TABLE dds.f_events DROP CONSTRAINT IF EXISTS f_clicks_d_page_url_id_fkey;
alter table dds.f_events add constraint f_clicks_d_page_url_id_fkey foreign key (page_url_id) references dds.d_page_url (id);
ALTER TABLE dds.f_events DROP CONSTRAINT IF EXISTS f_clicks_d_user_domain_id_fkey;
alter table dds.f_events add constraint f_clicks_d_user_domain_id_fkey foreign key (domain_id) references dds.d_user_domain (id);
