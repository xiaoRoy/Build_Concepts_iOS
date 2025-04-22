//
//  HelloWorld.h
//  FeatureFlag
//
//  Created by Jerry Li on 2025/4/22.
//

#ifndef HELLO_WORLD_H
#define HELLO_WORLD_H

// Use extern "C" if you want to easily call this from Objective-C or Swift
// extern "C" {

class HelloWorld {
public:
    // Constructor
    HelloWorld();

    // Method to print "Hello, World!"
    void printHello();

    // Optional: A C-style function wrapper for easier Objective-C/Swift interop
    // void printHelloWorldC();
};

// } // End extern "C"

#endif /* HelloWorld_h */
