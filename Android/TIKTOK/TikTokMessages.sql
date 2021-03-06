/* For this query to run the db_im_xx database must be attached to your working
messages table. The messages table has a 19 digit long filename witht the _im.db extension.
The messages table can be found using ([0-9]{19})(_im.db)$
In this sample query the attached database is named db_im_xx. You have to attach it
for this query to run as-is. This query was tested in DB Browser for SQLite
verion 3.10.1. For details see blog post here: https://abrignoni.blogspot.com/2018/11/finding-tiktok-messages-in-android.html

By: Alexis Brignoni
Twitter: @AlexisBrignoni
Blog: abrignoni.blogspot.com
*/

select
UID,
UNIQUE_ID,
NICK_NAME,
datetime(created_time/1000, 'unixepoch', 'localtime') as created_time,
json_extract(content, '$.text') as message,
json_extract(content,'$.display_name') as links_gifs_display_name,
json_extract(content, '$.url.url_list[0]') as links_gifs_urls,
read_status,
	case when read_status = 0 then 'Not read'
		when read_status = 1 then 'Read'
		else read_status
	end
	read_not_read,
local_info
from SIMPLE_USER, msg
where UID = sender order by created_time
