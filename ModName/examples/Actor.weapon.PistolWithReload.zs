class PistolWithReload : Pistol //it's based on the existing Pistol, so it inherits all of its properties
{
     Default
    {
        +WEAPON.AMMO_OPTIONAL //without this flag the weapon will be deselected as soon as the magazine is empty
        Weapon.AmmoType "PistolMagazine"; //a special "magazine" ammo type 
        Weapon.AmmoUse 1;
        Weapon.AmmoGive 0; //We don't want weapon pickups to refill the magazine
        Weapon.AmmoType2 "Clip"; //Clip is still used as reserve ammo
        Weapon.AmmoGive2 20; //the weapon will give some reserve ammo when picked up
    }

    // This defines a custom version of the A_WeaponReady function
    // that will block the ability to reload if the player
    // doesn't have any reserve ammo, or if their magazine
    // is already full:
    action void A_WeaponReadyReload(int flags = 0)
    {
        // Check that the amount of ammo1 (magazine) is lower than maxamount
        // and the amount of ammo2 (reserve ammo) is at least the same as ammouse1 
        // (the amount of magazine ammo required for firing):
        if (invoker.ammo1.amount < invoker.ammo1.maxamount && invoker.ammo2.amount >= invoker.ammouse1)
        {
            // If true, add WRF_ALLOWRELOAD to the flags, 
            // which is a A_WeaponReady() flag that allows 
            // using the Reload state sequence:
            flags |= WRF_ALLOWRELOAD;
        }
        // Pass the resulting value to A_WeaponReady 
        // (which will be either 0 or WRF_ALLOWRELOAD):
        A_WeaponReady(flags);
    }

    // This defines a custom function that in a loop takes
    // 1 ammo from reserve and adds 1 ammo to the magazine,
    // until either the reserve is empty ot the magazine
    // is full:
    action void A_MagazineReload()
    {
        // Loop this while ammo2 is above 0 AND ammo1 is
        // less than maximum:
        while (invoker.ammo2.amount > 0 && invoker.ammo1.amount < invoker.ammo1.maxamount) 
        {
            TakeInventory(invoker.ammotype2, 1); //take 1 of AmmoType2
            GiveInventory(invoker.ammotype1, 1); //give 1 of AmmoType1
        }
    }

    States
    {
    Ready:
        PISG A 1 A_WeaponReadyReload;
        Loop;
    Fire:
        // If PistolMagazine ammo is 0, jumps to Reload instead of firing:
        PISG A 4 A_JumpIfNoAmmo("Reload"); 
        PISG B 6 A_FirePistol;
        PISG C 4;
        PISG B 5 A_ReFire;
        Goto Ready;
    Reload:
        PISG AAAA 2 A_WeaponOffset(3, 5, WOF_ADD); //simply shifts the weapon downward and to the right
        PISG A 15; // simply wait for 15 tics
        TNT1 A 0  // perform the following anonymous function:
        {
            A_StartSound("misc/w_pkup"); //plays Doom's "weapon pickup" sound
            A_MagazineReload(); //do the reload
        }
        PISG AAAA 2 A_WeaponOffset(-3, -5, WOF_ADD); //shift the sprite upward and to the right
        goto Ready;
    }
}

// This is the magazine ammo; it's not based on any other ammo type:
class PistolMagazine : Ammo
{
    Default
    {
        Inventory.Amount 1; //default given amount
        Inventory.MaxAmount 10; //maximum amount (functions as the magazine capacity)
        Ammo.BackPackAmount 0; //Backpack shouldn't refill our magazines, so this is 0
        Ammo.BackPackMaxAmount 10; //backpack shouldn't increase our magazine capacity, so this is the same as maxamount
        +INVENTORY.IGNORESKILL //without this the player will receive 2 ammo on ITYTD and Nightmare! difficulties
        Inventory.Icon "PISTA0"; //this will use Pistol pickup sprite as its icon
    }
}
