


# Trew_EasyDeliveries
Delivery system coded on ESX.  
Made for you to create any delivery job you want to or create a delivery mission for an existing job.

## Requirements
* [es_extended](https://github.com/ESX-Org/es_extended)

## Demo  
I created a marker at the Ballas location and made an event that when you press **E**, it starts a delivery mission with 2 locations. If the player below doesn't work, the demonstration can be [found here](https://streamable.com/9nj17)
https://streamable.com/9nj17

## Download
https://github.com/vortisrd/trew_easydeliveries

## Usage and Example
Let's say you have a Ballas gang script and want to create a drug delivery mission. You need to:

 1. Create a marker to get the mission
 2. Create an array of blip locations
 3. Input the product you want to be delivered
 4. Start the mission

That being said, here's an example on how you could do that.


#### config.lua

```
    Config.DrugDeliveryBlipColor = 27
    Config.DrugDeliveryMarkerColor = { 210, 0, 255 }
    Config.DrugDeliveryPickup = { x = 84.72, y = -1958.43, z = 20.20 }
    Config.DrugDeliveryLocations = {
        { x = -1218.90,         y = 665.73,             z = 144.53 }, 
        { x = -1338.42,         y = 606.44,             z = 134.37 }, 
        { x = -1052.13,         y = 431.67,             z = 77.06 }, 
        { x = -904.04,          y = 191.49,             z = 69.04 },
        { x = -23.75,           y = -23.71,             z = 73.24 }, 
        { x = 226.15,           y = -283.52,            z = 49.35 }
    }
```


#### client.lua

```
    local Keys = {
        ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
    }


    isDeliveryGoing = false

    -- Countdown
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            if exports.trew_easydeliveries:deliveryStatus() == false then

                local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                local bz,cz = GetGroundZFor_3dCoord(Config.DrugDeliveryPickup['x'], Config.DrugDeliveryPickup['y'], Config.DrugDeliveryPickup['z'])
                local distance = GetDistanceBetweenCoords(Config.DrugDeliveryPickup['x'], Config.DrugDeliveryPickup['y'],cz,x,y,z,true)

                if distance <= 40 then

                    ballasDrawMarker(
                        1,
                        { Config.DrugDeliveryPickup['x'], Config.DrugDeliveryPickup['y'], Config.DrugDeliveryPickup['z'] },
                        { Config.DrugDeliveryMarkerColor[1],Config.DrugDeliveryMarkerColor[2],Config.DrugDeliveryMarkerColor[3] }
                    )

                    if distance <= 1.2 then

                        -- IF YOU PRESS E, YOU MAKE THE DELIVERY
                        if IsControlJustPressed(0,Keys['E']) and not IsPedInAnyVehicle(PlayerPedId()) then
                            TriggerServerEvent('esx_trew_ballas:drugDelivery')
                        else
                            SetTextComponentFormat('STRING')
                            AddTextComponentString('Pressione ~INPUT_PICKUP~ iniciar as entregas. ~b~')
                            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                        end
                    end

                end

            end

        end
    end)


    function ballasDrawMarker(markerType,markerCoords,makerColor)
        DrawMarker(
            markerType,
            markerCoords[1],markerCoords[2],markerCoords[3],
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            1.5, 1.5, 1.0,
            makerColor[1],makerColor[2],makerColor[3],
            100,
            false,
            true,
            2,
            true,
            false,
            false,
            false
        )
    end
```



#### server.lua

```


    RegisterServerEvent('esx_trew_ballas:drugDelivery')
    AddEventHandler('esx_trew_ballas:drugDelivery', function()

    TriggerEvent('trew_easydeliveries:start', {
        player = source,
        job = 'ballas',
        product = 'cocain_pouch',
        howmany = 10,
        label = 'Cocain sell', 
        title = 'Cocain delivery',
        reward = 1000,
        rewardtype = 'black_money',
        anim = {
            dict = 'anim@heists@money_grab@duffel',
            name = 'enter'
        },
        blipcolor = Config.DrugDeliveryBlipColor,
        markercolor = {
            r = Config.DrugDeliveryMarkerColor[1],
            g = Config.DrugDeliveryMarkerColor[2],
            b = Config.DrugDeliveryMarkerColor[3]
        },
        markervisibility = 40,
        blips = Config.DrugDeliveryLocations
    })



    end)
    
```

## Exported Functions
**exports.trew_easydeliveries:deliveryStatus()**
It tells you if the delivery is active or not

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

-- 

I hope you guys like it! :smiley:



## Download & Installation
1) Download the .zip.
2) Extract the .zip.
3) Place `trew_easydeliveries` in your ESX Directory
4) Add `start trew_easydeliveries` to your server.cfg



## Changelog
**Aug 30th, 2019**

 - Item consumption and rewarding were moved to server-side;
 - Item consumption is now random from 1 to a maximum of 5 (*default*), acting as a multiplier for the reward. You can change the maximum value in **config.lua**;
 - The locations are now randomly selected.
