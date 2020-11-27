/*
List each occurrence in which an avatar (by login as companion1 and avatar's name as fname) whose participation in quests within a given realm has always been together with a second avatar (by login as companion2 and name as lname) who has participated in exactly those same quests within the realm.

Since each pair of such companions would be shown twice — once with avatar X and avatar Y and once with avatar Y and avatar X — break the tie and show each such pair (per realm) just once; choose such that companion1 is before companion2 in dictionary order.

schema: companion1, fname, realm, companion2, lname
order by realm, companion1, fname, companion2, lname
*/

with participated as (
select distinct v.login, v.name, a.theme, a.realm, a.day
from actor a, visit v
where v.login = a.login 
and v.realm = a.realm 
and v.day = a.day
                ),


companions as (
select distinct a.login as companion1, a.name as fname, a.realm as realm, b.login as companion2, b.name as lname
from participated a, participated b
where a.login < b.login 
and a.name <> b.name
and a.realm = b.realm 
and a.theme = b.theme 
and a.day = b.day
            )

select  c.companion1, c.fname, c.realm, c.companion2, c.lname
FROM companions c

where not exists(
	(select p.realm, p.theme, p.day
	from participated p
	where p.login = c.companion1
	and p.realm = c.realm
	and p.name = c.fname)
	
	except

	(select p.realm, p.theme, p.day
	from participated p
	where p.login = c.companion2
	and p.realm = c.realm 
	and p.name = c.lname))

	and not exists(


	(select p.realm, p.theme, p.day
	from participated p
	where p.login = c.companion2
	and p.realm = c.realm
	and p.name = c.lname)
	
	except

	(select p.realm, p.theme, p.day
	from participated p
	where p.login = c.companion1
	and p.realm = c.realm
    and p.name = c.fname))

order by realm, companion1, fname, companion2, lname;