class GZDPistol : DoomWeapon //DoomWeapon is a base class based on Weapon. It only defines kickback (recoil).
{
     Default
    {
        // Weapon.SelectionOrder 1900 //defines the priority of selecting this weapons when others run out of ammo
        // Weapon.AmmoUse 1 //how much ammo it uses per shot
        // Weapon.AmmoGive 20 //how much ammo the weapon gives you when you get it
        // Weapon.AmmoType "Clip" //the class name of the ammo type used by the weapon
        // Obituary "$OB_MPPISTOL" //a message printed on the screen when one player kills another in multiplayer
        // +WEAPON.WIMPY_WEAPON;
        // defines the weapon as "weak" (switch to another as soon as possible)
        // Inventory.Pickupmessage "$PICKUP_PISTOL_DROPPED" //the message printed on the screen when picking this up
        // Tag "$TAG_PISTOL" //name of the weapon
    }

    States
    {
        // Ready sequence is the default sequence used when the weapon is prepared:
        Ready:
            PISG A 1 A_WeaponReady; //makes the weapon ready for firing (will react to pressing Fire button)
            Loop;
        // Deselect sequence is played when you're switching to another weapon:
        Deselect:
            PISG A 1 A_Lower; //lowers the weapon on the screen until it disappears, then selects another weapon
            Loop;
        // Select sequence is played when you've switched to this weapon:
        Select:
            PISG A 1 A_Raise; //raises the weapon from below the screen, then goes to Ready
            Loop;
        // Fire sequence is played when you press Fire while A_WeaponReady() was called:
        Fire:
            PISG A 4;
            PISG B 6 A_FirePistol; //default Doom pistol attack
            PISG C 4;
            PISG B 5 A_ReFire; //loops the sequence if the player was holding down Fire button
            Goto Ready; //otherwise goes back to ready
        // Flash sequence draws a muzzle flash on a separate layer, on top of the main weapon sprite:
        Flash:
            PISF A 7 Bright A_Light(1); //illuminates the whole level
            Goto LightDone;
        // Spawn sequence is used when the weapon is spawned in the world:
        Spawn:
            PIST A -1;
            Stop;
    }
}
