select login, name, gender, address, joined
from player
where lower(name) like lower('%' || player.login || '%')
order by login;