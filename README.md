# esx-qalle-needs

``jsfour-toilet as base.``

[REQUIREMENTS]
  
* ESX Support
  * esx_basicneeds // for bars etc.
  * esx_status // for bars etc.
  
[INSTALLATION]

1) CD in your resources/[esx] folder

2) Add this in your server.cfg :
``start esx-qalle-needs``

3) Add this into the esx_basicneeds for bars:

```lua
	--For Shit Bars
	TriggerEvent('esx_status:registerStatus', 'shit', 1000000, '#663300', -- amarelo
		function(status)
			return true
		end,
	function(status)
		status.remove(40)
	end)
	
	--For Pee Bars
	TriggerEvent('esx_status:registerStatus', 'pee', 1000000, '#FFFF00', -- amarelo
		function(status)
			return true
		end,
	function(status)
		status.remove(40)
	end)
```
