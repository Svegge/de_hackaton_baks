CREATE TABLE IF NOT EXISTS stg.stg_logs (
   id SERIAL,
 event_timestamp TIMESTAMP,
 event_type VARCHAR,
 page_url VARCHAR,
 page_url_path VARCHAR,
 referer_url VARCHAR,
 referer_url_scheme VARCHAR, 
 referer_url_port INT,
 referer_medium VARCHAR,
 utm_medium VARCHAR, 
 utm_source VARCHAR, 
 utm_content VARCHAR, 
 utm_campaign VARCHAR,
 click_id VARCHAR,
 geo_latitude NUMERIC(12, 8), 
 geo_longitude NUMERIC(12, 8),
 geo_country VARCHAR,
 geo_timezone VARCHAR,
 geo_region_name VARCHAR,
 ip_address VARCHAR,
 browser_name VARCHAR,
 browser_user_agent VARCHAR,
 browser_language VARCHAR,
 os VARCHAR,
 os_name VARCHAR,
 os_timezone VARCHAR,
 device_type VARCHAR,
 device_is_mobile BOOL,
 user_custom_id VARCHAR,
 user_domain_id VARCHAR
);