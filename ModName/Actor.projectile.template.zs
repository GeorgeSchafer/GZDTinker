version "4.11.3"

class PROJECTILE : Actor
{
    // This is where class-scope variables (aka fields)
    // are usually defined.
    int foo; // example of an integer variable
    double bar; //example of a double (float-point) variable

    Default
    {
        // This is where properties and flags are defined.
        // They define the actor's initial behavior, when
        // it spawns. Most of them can be dynamically
        // changed later.
        Projectile
/*      Projectile flags
            +NOBLOCKMAP
            +NOGRAVITY
            +DROPOFF
            +MISSILE
            +ACTIVATEIMPACT
            +ACTIVATEPCROSS
            +NOTELEPORT
            +BLOODSPLATTER (When playing Heretic or Hexen) */


    }

    // This is where functions are usually defined.
    // These can include both fully custom functions,
    // and virtual functions override (more on those
    // later).

    // An example of a custom function:
    void MyFunction()
    {
        // do something
    }

    // This is an example of a virtual function override.
    // Tick() is a function that all actors run automatically
    // every tic (1/35 second) while they exist in a level.
    // By overriding it, you can add extra behavior into
    // the actor without having to define it inside its
    // animation states:
    override void Tick()
    {
        // You need to call super.Tick() first to make sure
        // that the default Actor class Tick() is called
        // ("super" in this context means "parent class'").
        // The base Actor Tick() is where stuff like
        // collision, movement, animation progression and
        // such happen.
        super.Tick();

        // You can add more behavior here.
    }

    // The keyword States begings a states block that
    // defines the actor's animation states and
    // related behavior:
    States
    {
    // All actors enter their Spawn state sequence
    // by default when they spawn:
    Spawn:
        SPRITE ABCD 1; //display TROOA, TROOB, TROOC and TROOD sprites, each for 1 tic
        loop; //loop the state sequence
    }
}
