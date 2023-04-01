insert into dds.d_page_url (page_url_path)
select distinct substr(page_url_path, 2)
from stg.stg_logs sl
where substr(page_url_path, 2) not in (select page_url_path from dds.d_page_url);
