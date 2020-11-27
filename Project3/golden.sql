/*
List each quest by realm, day, and theme which offered a prize (treasure) with “Gold” in the name which was rewarded to some player.

schema: realm, day, theme
order by day, realm, theme

*/
select distinct realm, day, theme
from loot
where loot.login is not null
and loot.treasure like '%Gold%'
order by  day, realm, theme;


