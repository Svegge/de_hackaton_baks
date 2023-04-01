--drop materialized view cdm.v_dm_top10_referers;
create materialized view if not exists cdm.v_dm_top10_referers as 
--
select t."year", t."month", t."day", t."hour", date_trunc('hour', t.ts) dt_hour
		, r.referer_url
		, count(event_id) as event_id_cnt
from dds.f_events f
join dds.d_page_url p on f.page_url_id = p.id
join dds.d_referer r on f.referer_id = r.id
join dds.d_timestamps t on f.timestamp_id = t.id
where p.page_url_path = 'confirmation'
group by t."year", t."month", t."day", t."hour", dt_hour, r.referer_url;
