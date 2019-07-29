# rad_gsr - v1.2
**Version:** 1.2

Created/Updated by - BattleRattt & BenZoN

**Requirements rad_gsr**
[es_extended](https://github.com/ESX-Org/es_extended) & 
[mythic_progbar](https://github.com/mythicrp/mythic_progbar) & 
[mythic_notify](https://github.com/mythicrp/mythic_notify) & 
[mysql-async](https://github.com/brouznouf/fivem-mysql-async)


**Description**
This script will allow players with the "police" job to run a GSR (gun shot residue) test to see if a player has shot a gun within a certain amount of time.

**Features**
- When a player shoots they will automatically be marked with GSR for a certain amout of time (can change in config).
- Police can do /gsr <id> or use the police menu if you add it using instructions below.
- Allows player to wash off GSR when they get in water.
- Full config to allow you to customize everything you need.
- Config option to show the suspects name in the notification. This allows the cop to make sure they checked the right person.
- Clean notifications and progress bar thanks to mythic_progbar and mythic_notify!
- No database necessary

**Installation rad_gsr**
- Download -https://github.com/radiant-gaming-public/rad_gsr
- Put it in the `resources` directory
- Add this to your  `server.cfg`:
```
start rad_gsr
```

**Integration with esx_policejob**

**Find.**
```
local elements = {
	{label = _U('id_card'),			value = 'identity_card'},
	{label = _U('search'),			value = 'body_search'},
	{label = _U('handcuff'),		value = 'handcuff'},
	{label = _U('drag'),			value = 'drag'},
	{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
	{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
	{label = _U('fine'),			value = 'fine'},
	{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
```
Insert
```
	{label = "GSR Test",			value = 'gsr_test'}
```

**So you get something like.**
```
local elements = {
	{label = _U('id_card'),			value = 'identity_card'},
	{label = _U('search'),			value = 'body_search'},
	{label = _U('handcuff'),		value = 'handcuff'},
	{label = _U('drag'),			value = 'drag'},
	{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
	{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
	{label = _U('fine'),			value = 'fine'},
	{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
	{label = "GSR Test",			value = 'gsr_test'}
```

**Then a bit below find.**
```
elseif action == 'unpaid_bills' then
	OpenUnpaidBillsMenu(closestPlayer)
```

**After that insert.**
```
elseif action == 'gsr_test' then
	TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
```

**So it looks like this.**
```
elseif action == 'unpaid_bills' then
	OpenUnpaidBillsMenu(closestPlayer)
elseif action == 'gsr_test' then
	TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
end
```

## Legal
rad_gsr - GSR Test

Copyright (C) 2015-2018 BattleRattt and BenZoN

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see  [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
