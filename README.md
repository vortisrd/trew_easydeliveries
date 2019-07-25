# Trew_EasyDeliveries
Delivery system coded on ESX.  
Made for you to create any delivery job you want to or create a delivery mission for an existing job.

## Demo  
The demonstration can be [found here](https://streamable.com/9nj17). I created a marker at the Ballas location and made an event that when you press **E**, it starts a delivery mission with 2 locations.

## Usage
There's an example below using the Ballas gang job to create a cocain delivery mission. Usually, you should create a marker and start the event when pressing any button at it.
```

    TriggerEvent('trew_easydeliveries:start', {
        job = 'ballas',
        product = 'cocain_pouch',
        howmany = 5,
        label = 'Cocain', 
        title = 'Cocain delivery mission started!',
        reward = 1000,
        rewardtype = 'black',
        anim = {
            dict = 'pickup_object',
            name = 'putdown_low'
        },
        blipcolor = 27,
        markercolor = {
            r = 210,
            g = 0,
            b = 255
        },
        markervisibility = 40,
        blips = {
            { x = -904.04,          y = 191.49,             z = 69.04 },
            { x = -23.75,           y = -23.71,             z = 73.24 }, 
            { x = 226.15,           y = -283.52,            z = 49.35 }, 
            { x = 5.97,             y = -708.16,            z = 45.97 }, 
            { x = 285.29,           y = -937.44,            z = 29.38 }, 
            { x = 411.78,           y = -1487.88,           z = 30.14 },
        }
    }, function(status)

        if status == true then
            print('The deliveries were made')
        elseif status == 'not_enough_items' then
            print('You ran out of items')
        elseif status == 'delivery_cancelled' then
            print(' The deliveries were cancelled')
        elseif status == 'dead' then
            print(' You died')
        else
            print('Something went wrong and I don't know what it is')
        end

    end)
    
```

## Variables
**job**  
The job you want to create the delivery. Ex: ballas, losvagos, baker, pizzaman, etc.
*Must be the same identifier as in the database*

**product**  
The job you want to create the delivery. Ex: cocain_pouch, bread, pizza, etc.  
*Must be the same identifier as in the database*

**howmany**  
The amount of deliveries you want to make. It's important for it to be equal or bigger than the amount of blips.

**label**  
Blip label on the map

**title**  
The title of the delivery action

**reward**  
The amount of money you receive each delivery made

**rewardtype**  
The type of money you receive. If it's set to ***cash*** it goes to your wallet, ***black*** it goes as black money and ***bank*** if you want it to go straight to your bank account.

**anim**   
If you want animations, you need to specify this variable as a table, using the following options:

 - **dict**: The animation dictionary
 - **anim**: The animation id

*More info on animations [here](https://alexguirre.github.io/animations-list/).  
There's a YouTube channel containing video on a bunch of animations and it's IDs. [Take a look](https://www.youtube.com/channel/UCzkFiWms11gxAip6n0cQz3A).*

**blipcolor**  
The color of the blip and the route on the map. [Here's a list of blip color codes](https://gtaforums.com/topic/864881-all-blip-color-ids-pictured/).

**markercolor**  
The RGB color code, on where:
 - **r**: The amount of RED
 - **g**: The amount of GREEN
 - **b**: The amount of BLUE

**markervisibility**  
It defines how many meters your blip will be visible for you

**blips** 
The delivery locations identifiers. You should use the pattern

 - **x**: the X axis
 - **y**: the Y axis
 - **z**: the Z axis

**function callback**  
It returns ***true*** when you complete a delivery, ***not_enough_items*** if you run out of items in the middle of a delivery mission, ***delivery_cancelled*** if your delivery was cancelled, **dead** if you die and ***false*** for other reasons.



## Download & Installation
1) Download the .zip.
2) Extract the .zip.
3) Place `trew_easydeliveries` in your ESX Directory
4) Add `start trew_easydeliveries` to your server.cfg


## Discord

<img src="https://discordapp.com/api/guilds/531620822054600714/widget.png?style=banner2" alt="Discord Banner 2"/>

