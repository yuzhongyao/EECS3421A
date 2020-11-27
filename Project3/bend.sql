/*
List each player by login, name, and gender who gender swapped at least once with their avatars, along with the count of how many avatars that he or she has (avatars).

schema: login, name, gender, avatars
order by login


*/
with more_than_one_login as
    (
    select distinct player.login,  count(*) as avatars
    from avatar, player
    where avatar.login = player.login
    group by player.login
    having count(*) > 1
 
    ),

more_than_one_gender as (
    select distinct player.login, player.gender
    from player, more_than_one_login a, avatar b
    where a.login = player.login
    and a.login = b.login
    and b.login = player.login
    and b.gender <> player.gender
   
)

select player.login, player.name, player.gender, a.avatars
from player, more_than_one_gender, more_than_one_login a
where player.login = a.login
and player.login = more_than_one_gender.login
and more_than_one_gender.login = a.login
 order by login;