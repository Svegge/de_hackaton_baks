drop materialized view if exists cdm.v_dm_product_purchase;

create materialized view if not exists cdm.v_dm_product_purchase as 
--
with t as (
	select t."year", t."month", t."day", t."hour", date_trunc('hour', t.ts) dt_hour 
		, u.user_domain_id 
		, count(case when page_url_path = 'cart' then event_id end) as product_purch
		, count(case when page_url_path = 'confirmation' then event_id end) as purch_cnt
	from dds.f_events f
	join dds.d_page_url p on f.page_url_id = p.id
	join dds.d_timestamps t on f.timestamp_id = t.id
	join dds.d_user_domain u on f.domain_id = u.id
	group by t."year", t."month", t."day", t."hour", dt_hour, u.user_domain_id
	)
select "year", "month", "day", "hour", dt_hour, sum(product_purch) as product_cnt
from t 
where product_purch > 0 and purch_cnt > 0
group by "year", "month", "day", "hour", dt_hour;
