Native Sample
===

The native sample demonstrates how to create a fully native class. The class itself is
created in C code and its properties are represented as C language types.  A native 
class can be the most compact representation for some data types and is useful for 
creating virtual storage for properties. The native module is called nclass and the 
native class is called Shape.

## Files:

    Shape.es        - Class file for the Shape class
    Shape.c         - Native methods for the Shape class. Also contains the modules 
                      initialization entry point.
    nclass.slots.h  - Generated slot offsets for the Shape class. Generated by ejsmod.
    main.es         - Main test program

## To build:

    bit

## To build and show commands:

    bit -s

## To run:

    ejs main.es

## See Also:

    The composite sample for how to create a composite native class in which the class is
    created by the runtime and the properties are real JavaScript objects.