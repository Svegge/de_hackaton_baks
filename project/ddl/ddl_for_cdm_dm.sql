--Проектирование витрин CDM
--=======================
/*
 Для базовой части создаем 3 витрины под каждую из требуемых бизнесом визуализаций
 */

--Распределение событий по часам
drop table if exists cdm.dm_events_by_hour;
--
create table cdm.dm_events_by_hour (
	id serial not null primary key, -- идентификатор записи
	hour_d integer not null,-- час
	event_type varchar not null, -- событие
	event_cnt integer not null 
		default 0 check(event_cnt >= 0),-- кол-во кликов
	constraint dm_events_by_hour_hour_d_event_type_unique 
		unique(hour_d, event_type) --уникальное значение часа и события
);

--=======================
--количество купленных товаров в разрезе часа
--
--предполагаем что при событии event_type = 'purchase' - page_url_path - это наименование товара
--в витрине получаем час, наименование товара и кол-во покупок(кликов)
drop table if exists cdm.dm_product_purchase;
--
create table cdm.dm_product_purchase (
	id serial not null primary key, -- идентификатор записи
	hour_d integer not null,-- час
	purchase_product varchar not null, -- товара
	purchase_cnt integer not null 
		default 0 check(purchase_cnt >= 0),-- кол-во покупок
	constraint dm_product_purchase_hour_d_purchase_product_unique 
		unique(hour_d, purchase_product)
);

--=======================
--топ-10 посещённых страниц, с которых был переход в покупку — список ссылок с количеством покупок
drop table if exists cdm.dm_top10_referers;
--
create table cdm.dm_top10_referers (
	id serial not null primary key, -- идентификатор записи
	referer_url varchar not null, -- ссылка
	purchase_cnt integer not null -- кол-во покупок
);