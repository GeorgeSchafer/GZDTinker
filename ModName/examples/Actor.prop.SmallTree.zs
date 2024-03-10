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
