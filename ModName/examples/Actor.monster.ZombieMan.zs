class ZombieMan : Actor
{
    Default
    {
        Health 20;
        Radius 20;
        Height 56;
        Speed 8; //How many map units it can move per A_Chase call (see See state sequence below)
        PainChance 200; //how often the monster will flinch when attacked
        Monster; //this keywords adds various flags that define this actor as a monster
        +FLOORCLIP //it'll be submerged into deep water if defined in TERRAIN lump
        SeeSound "grunt/sight"; //the sound played when it sees a player
        AttackSound "grunt/attack"; //the sound played when attacking
        PainSound "grunt/pain"; //the sound played when entering its Pain state sequence
        DeathSound "grunt/death"; //the sound played when A_Scream is called (see Death sequence)
        ActiveSound "grunt/active"; //the sound played periodically when it's chasing the player
        Obituary "$OB_ZOMBIE"; //a LANGUAGE lump reference that contains "played was killed by a Zombieman" string
        Tag "$FN_ZOMBIE"; //an internal name for the monster
        DropItem "Clip"; //an item it'll drop when killed
    }
     States
    {
    // The animation sequence at actor spawn:
    Spawn:
        POSS AB 10 A_Look; //this makes the monster listen for and look for players
        Loop;
    // See sequence is used when an alerted monster is chasing the player:
    See:
        POSS AABBCCDD 4 A_Chase; //a basic walking and chasing function
        Loop;
    // Missile sequence is entered when the monster tries to attack the player:
    Missile:
        POSS E 10 A_FaceTarget; //the monster turns towards its target
        POSS F 8 A_PosAttack; //the monster uses a standard Zombieman attack
        POSS E 8;
        Goto See;
    // Pain sequence is entered when the monster is shot
    // and its painchance check succeeds:
    Pain:
        POSS G 3;
        POSS G 3 A_Pain; //plays painsound (see Default block)
        Goto See;
    // Death sequence is entered when the monster
    // is killed (its health reaches 0):
    Death:
        POSS H 5;
        POSS I 5 A_Scream; //plays deathsound (see Default block)
        POSS J 5 A_NoBlocking; //makes the monster non-solid and spawns its Dropitem
        POSS K 5;
        POSS L -1; //final frame of the unmoving corpse
        Stop;
    // XDeath sequence is entered when the monster was dealt very high damage
    // and its health was reduced to a negative value that is equal or below
    // its default Health value (by default):
    XDeath:
        POSS M 5;
        POSS N 5 A_XScream; //plays a gibbed player sound, defined globally
        POSS O 5 A_NoBlocking; //makes the monster non-solid and spawns its Dropitem
        POSS PQRST 5;
        POSS U -1; //final frame of the unmoving gibbed corpse
        Stop;
    // Raise sequence is used when the monster is resurrected by an Arch-Vile.
    // If this isn't defined in a monster, it can't be resurrected.
    Raise:
        POSS K 5;
        POSS JIH 5;
        Goto See;
    }
}
