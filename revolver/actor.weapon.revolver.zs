class Revolver : DoomWeapon //DoomWeapon is a base class based on Weapon. It only defines kickback (recoil).
{
     Default
    {
        /*
        * @param Weapon.SelectionOrder { int }
        *       defines the priority of selecting this weapons when others
        *       run out of ammo */
        // Weapon.SelectionOrder 1899

        /*
        * @param Weapon.AmmoUse { int }
        *       how much ammo it uses per shot */
        // Weapon.AmmoUse 1

        /*
        * @param Weapon.AmmoGive { int }
        *       how much ammo the weapon gives you when you get it */
        // Weapon.AmmoGive 6

        /*
        * @param Weapon.AmmoType { string }
        *       the class name of the ammo type used by the weapon */
        // Weapon.AmmoType "magna"
        
        /*
        * @param Obituary  { string }
        *       a message printed on the screen when one player kills another in multiplayer */
        // Obituary "You got blasted by the magnum"
        
        /*
        * @param +WEAPON.WIMPY_WEAPON { boolean } 
        *       defines the weapon as "weak" (switch to another as soon as possible) */
        // -WEAPON.WIMPY_WEAPON

        /*
        * @param Inventory.Pickupmessage { string }
        *       the message printed on the screen when picking this up */
        // Inventory.Pickupmessage "Picked up a revolver"

        /*
        * @param Tag { string }
        *       name of the weapon*/
        // Tag "$TAG_REVOLVER"
    }

    States
    {
        // Ready sequence is the default sequence used when the weapon is prepared:
        Ready:
            rev1 A A_WeaponReady; //makes the weapon ready for firing (will react to pressing Fire button)
            Loop;
        // Deselect sequence is played when you're switching to another weapon:
        Deselect:
            rev1 A A_Lower; //lowers the weapon on the screen until it disappears, then selects another weapon
            Loop;
        // Select sequence is played when you've switched to this weapon:
        Select:
            rev1 A A_Raise; //raises the weapon from below the screen, then goes to Ready
            Loop;
        // Fire sequence is played when you press Fire while A_WeaponReady() was called:
        Fire:
            rev2 A;
            rev3 A A_FirePistol; // A_FirePistol default Doom pistol attack
            rev4 A;
            rev5 A A_ReFire; //loops the sequence if the player was holding down Fire button
            Goto Ready; //otherwise goes back to ready
        // Flash sequence draws a muzzle flash on a separate layer, on top of the main weapon sprite:
        Flash:
            PISF A 7 Bright A_Light1; //illuminates the whole level
            Goto LightDone;
        // Spawn sequence is used when the weapon is spawned in the world:
        Spawn:
            rev0 A -1;
            Stop;
    }
}

// class Magna : Ammo
// {
//     Default
//     {
//         /*
//         * @param Inventory.Amount { int }
//         *       default given amount
//         * @param Inventory.MaxAmount { int }
//         *       maximum amount (functions as the magazine capacity)
//         * @param Ammo.BackPackAmount { int }
//         *       Backpack shouldn't refill our magazines, so this is 0
//         * @param Ammo.BackPackAmount { int }
//         *       backpack shouldn't increase our magazine capacity, so this is the same as maxamount
//         * @param +INVENTORY.IGNORESKILL { boolean }
//         *       without this the player will receive 2 ammo on ITYTD and Nightmare! difficulties
//         * @param Inventory.Icon { string }
//         *       this will use Pistol pickup sprite as its icon
//         */
//         Inventory.Amount 6;
//         Inventory.MaxAmount 12;
//         Ammo.BackPackAmount 0;
//         Ammo.BackPackMaxAmount 64;
//         +INVENTORY.IGNORESKILL
//         Inventory.Icon "rev0";
//     }
// }