// NOTE: this actor already exists in GZDoom and doesn't need to be redefined
// I'm using it purely as an example.

class BigTree : Actor
{
    Default
    {
        Radius 32; //actor's width (collision with monster/player)
        Height 108; //actor's height (collision with monster/player)
        ProjectilePassHeight -16; //reduces vertical hitbox for projectiles by 16 units
        +SOLID //solid: other actors/projectiles can't pass through it, hitscan attacks can
    }
    States
    {
    Spawn:
        TRE2 A -1; //setting duration to -1 makes it not animate
        Stop;
    }
}
If you want to define a custom version of BigTree that is similar to the existing one, you can do it by using inheritance:

class SmallerTree : BigTree
{
    Default 
    {
        Scale 0.5; //this makes the actor's sprite visually smaller
        Radius 16; //radius and height need to be redefined manually
        Height 54;
    }
}
// In this example states aren't redefined because
// we're reusing the existing animation from BigTree
