insert into dds.d_referer (referer_url, referer_medium)
select distinct 
	 referer_url
	,referer_medium
from stg.stg_logs sl
where referer_url not in (select referer_url from dds.d_referer);
