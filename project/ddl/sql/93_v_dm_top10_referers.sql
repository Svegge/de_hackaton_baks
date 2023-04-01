drop materialized view if exists cdm.v_dm_top10_referers;

create materialized view cdm.v_dm_top10_referers as 
--
select r.referer_url
  , count(event_id) as event_id_cnt
from dds.f_events f
join dds.d_page_url p on f.page_url_id = p.id
join dds.d_referer r on f.referer_id = r.id
join dds.d_timestamps t on f.timestamp_id = t.id
where p.page_url_path = 'confirmation'
group by r.referer_url
order by event_id_cnt desc 
limit 10;
