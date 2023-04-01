

select count(user_domain_id), count(distinct user_domain_id) from dds.d_user_domain;

--dds.f_clicks
insert into dds.f_events (event_id, timestamp_id, referer_id, page_url_id, domain_id)
select distinct 
	 sl.event_id 
	,dt.id as timestamp_id
	,dr.id as referer_id
	,dpu.id as page_url_id
	,dud.id as domain_id
from stg.stg_logs sl
left join dds.d_timestamps dt 
	on sl.event_timestamp::timestamp = dt.ts 
left join dds.d_referer dr 
	on sl.referer_url = dr.referer_url 
left join dds.d_page_url dpu 
	on substr(sl.page_url_path, 2)  = dpu.page_url_path 
left join dds.d_user_domain dud 
	on sl.user_domain_id = dud.user_domain_id
where sl.event_id not in (select event_id from dds.f_clicks);

select * from dds.f_events limit 50;