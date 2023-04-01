--dds.d_user_domain
INSERT INTO dds.d_user_domain (user_domain_id)
select distinct sl.user_domain_id 
from stg.stg_logs sl 
where sl.user_domain_id not in (select user_domain_id from dds.d_user_domain);
