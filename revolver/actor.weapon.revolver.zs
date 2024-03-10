class  Revolver : DoomWeapon
/* @class Revolver { DoomWeapon } 
 *      DoomWeapon is a base class based on Weapon. Weapon only defines 
 *      kickback (recoil).                                                */
{
     Default
    {
       /* @param Weapon.SelectionOrder { int }
        *       defines the priority of selecting this weapons when others
        *       run out of ammo                                           */
        Weapon.SelectionOrder 1901;

       /* @param Weapon.AmmoUse { int }
        *       how much ammo it uses per shot                            */
        Weapon.AmmoUse 1;

       /* @param Weapon.AmmoGive { int }
        *       how much ammo the weapon gives you when you get it        */
        Weapon.AmmoGive 6;

       /* @param Weapon.AmmoType { string }
        *       the class name of the ammo type used by the weapon        */
        Weapon.AmmoType "clip";

       /* @param Obituary  { string }
        *       a message printed on the screen when one player kills 
        *       another in multiplayer                                    */
        Obituary "You got blasted by the magnum";

       /* @param +WEAPON.WIMPY_WEAPON { boolean } 
        *       defines the weapon as "weak" (switch to another as soon as 
        *       possible)                                                 */
        // +WEAPON.WIMPY_WEAPON;

       /* @param Inventory.Pickupmessage { string }
        *       the message printed on the screen when picking this up    */
        Inventory.Pickupmessage "Picked up a revolver";

       /* @param Tag { string }
        *       name of the weapon                                        */
        Tag "$TAG_REVOLVER";
    }

    States
    {
        Ready:
            /* @state Ready
            *       Ready sequence is the default sequence used when the 
            *       weapon is prepared                                        */
            RVLV A 1 A_WeaponReady;
                /* @param A_WeaponReady { method }
                *       makes the weapon ready for firing (will react to 
                *       pressing Fire button)                                 */
            Loop;
        Deselect:
       /* @state Deselect
        *       Deselect sequence is played when you're switching to 
        *       another weapon                                            */
            RVLV A 4 A_Lower;
           /* @param A_Lower { method }
            *       lowers the weapon on the screen until it disappears, 
            *       then selects another weapon                           */
            Loop;

        Select:
       /* @state Select
        *       Select sequence is played when you've switched to this 
        *       weapon                                                    */
            RVLV A 4 A_Raise; //raises the weapon from below the screen, then goes to Ready
            Loop;


        Fire:
       /* @state Fire
        *       Fire sequence is played when you press Fire while 
        *       A_WeaponReady() was called                                */
            RVLV B 4;
            RVLV C 6 A_FirePistol; // A_FirePistol default Doom pistol attack
            RVLV D 4;
            RVLV E 5 A_ReFire; //loops the sequence if the player was holding down Fire button
            Goto Ready; //otherwise goes back to ready

        Flash:
       /* @state Flash
        *       Flash sequence draws a muzzle flash on a separate layer, 
        *       on top of the main weapon sprite                          */
            RVLV C 7 Bright A_Light1; //illuminates the whole level
            Goto LightDone;

        Spawn:
       /* @state Spawn
        *       Spawn sequence is used when the weapon is spawned in the 
        *       world                                                     */
            RVLV Z -1;
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
//         */
//         Inventory.Amount 6;
//         /*
//         * @param Inventory.MaxAmount { int }
//         *       maximum amount (functions as the magazine capacity)
//         */
//         Inventory.MaxAmount 12;
//         /*
//         * @param Ammo.BackPackAmount { int }
//         *       Backpack shouldn't refill our magazines, so this is 0
//         */
//         Ammo.BackPackAmount 0;
//         /*
//         * @param Ammo.BackPackMaxAmount { int }
//         *       backpack shouldn't increase our magazine capacity, so this is the same as maxamount
//         */
//         Ammo.BackPackMaxAmount 64;
//         /*
//         * @param +INVENTORY.IGNORESKILL { boolean }
//         *       without this the player will receive 2 ammo on ITYTD and Nightmare! difficulties
//         */
//         +INVENTORY.IGNORESKILL;
//         /*
//         * @param Inventory.Icon { string }
//         *       this will use Pistol pickup sprite as its icon
//         */
//         Inventory.Icon "RVLVZ";

        // Inventory.Amount 6;
        // Inventory.MaxAmount 12;
        // Ammo.BackPackAmount 0;
        // Ammo.BackPackMaxAmount 64;
        // +INVENTORY.IGNORESKILL;
        // Inventory.Icon "RVLVZ";
//     }
// }