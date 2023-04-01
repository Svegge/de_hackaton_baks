drop materialized view if exists cdm.v_dm_events_by_hour;

create materialized view if not exists cdm.v_dm_events_by_hour as 
--
select t."year", t."month", t."day", t."hour", date_trunc('hour', t.ts) dt_hour
	, case when p.page_url_path like '%product%' then 'product_view'
		else p.page_url_path end as event_type
	, count(f.event_id) as event_cnt
from dds.f_events f
join dds.d_page_url p on f.page_url_id = p.id
join dds.d_timestamps t on f.timestamp_id = t.id
group by t."year", t."month", t."day", t."hour", dt_hour, event_type;
