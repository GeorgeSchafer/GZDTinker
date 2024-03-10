class Pistol : DoomWeapon //DoomWeapon is a base class based on Weapon. It only defines kickback (recoil).
{
     Default
    {
        /*
        * @param Weapon.SelectionOrder { int }
        *       defines the priority of selecting this weapons when others
        *       run out of ammo
        * @param Weapon.AmmoUse { int }
        *       how much ammo it uses per shot
        * @param Weapon.AmmoGive { int }
        *       how much ammo the weapon gives you when you get it
        * @param Weapon.AmmoType { string }
        *       the class name of the ammo type used by the weapon
        * @param Obituary  { string }
        *       a message printed on the screen when one player kills another in multiplayer
        * @param +WEAPON.WIMPY_WEAPON { boolean } 
        *       defines the weapon as "weak" (switch to another as soon as possible)
        * @param Inventory.Pickupmessage { string }
        *       the message printed on the screen when picking this up
        * @param Tag { string }
        *       name of the weapon
        */
        int pickup Random(1,6)

        Weapon.SelectionOrder 1899 
        Weapon.AmmoUse 1
        Weapon.AmmoGive pickup
        Weapon.AmmoType "Magna"
        Obituary "You got blasted by the magnum"
        -WEAPON.WIMPY_WEAPON
        Inventory.Pickupmessage "Picked up a revolver"
        Tag "$TAG_REVOLVER"
    }
    States
    {
        // Ready sequence is the default sequence used when the weapon is prepared:
        Ready:
            REVO A 1 A_WeaponReady; //makes the weapon ready for firing (will react to pressing Fire button)
            Loop;
        // Deselect sequence is played when you're switching to another weapon:
        Deselect:
            REVO A 1 A_Lower; //lowers the weapon on the screen until it disappears, then selects another weapon
            Loop;
        // Select sequence is played when you've switched to this weapon:
        Select:
            REVO A 1 A_Raise; //raises the weapon from below the screen, then goes to Ready
            Loop;
        // Fire sequence is played when you press Fire while A_WeaponReady() was called:
        Fire:
            REVO B 1;
            REVO C 1; // A_FirePistol default Doom pistol attack
            REVO D 1;
            REVO B 1 A_ReFire; //loops the sequence if the player was holding down Fire button
            Goto Ready; //otherwise goes back to ready
        // Flash sequence draws a muzzle flash on a separate layer, on top of the main weapon sprite:
        Flash:
            PISF A 7 Bright A_Light1; //illuminates the whole level
            Goto LightDone;
        // Spawn sequence is used when the weapon is spawned in the world:
        Spawn:
            PIST A -1;
            Stop;
    }
}

class Magna : Ammo
{
    Default
    {
        /*
        * @param Inventory.Amount { int }
        *       default given amount
        * @param Inventory.MaxAmount { int }
        *       maximum amount (functions as the magazine capacity)
        * @param Ammo.BackPackAmount { int }
        *       Backpack shouldn't refill our magazines, so this is 0
        * @param Ammo.BackPackAmount { int }
        *       backpack shouldn't increase our magazine capacity, so this is the same as maxamount
        * @param +INVENTORY.IGNORESKILL { boolean }
        *       without this the player will receive 2 ammo on ITYTD and Nightmare! difficulties
        * @param Inventory.Icon { string }
        *       this will use Pistol pickup sprite as its icon
        */
        Inventory.Amount 0;
        Inventory.MaxAmount 12;
        Ammo.BackPackAmount 0;
        Ammo.BackPackMaxAmount 48;
        +INVENTORY.IGNORESKILL
        Inventory.Icon "REVO_I";
    }
}