#include <iostream>
#include <chrono>
#include "pcg_extras.hpp"
#include "Coin.cpp"

using namespace std;

Coin flipper;

//resets flipper
//flips coins until 3 heads are hit
//Display:
//  0 = display everything
//  1 = display no heads
// anything else = no display
void ThreeHeadsTest(bool RandomSeed, bool DisplayHeads) {
    //blank slate
    flipper.Reset();

    //set to a random seed if requested
    if (RandomSeed) {
        flipper.Reseed(chrono::high_resolution_clock::now().time_since_epoch().count());
    }

    //flip until 3 heads
    while (flipper.heads < 3) {
        flipper.Flip();
    }

    //display results if requested
    if (DisplayHeads == true) {
        flipper.Display();
    } else {
        flipper.DisplayNoHeads();
    }
}

//flips the coin until flips is hit
void SpamFlipTest(int flips, bool RandomSeed) {
    if (RandomSeed) {
        flipper.Reseed(chrono::high_resolution_clock::now().time_since_epoch().count());
    }

    for (int i = 0; i < flips; i++) {
        flipper.Flip();
    }
}

void SpamFlipObservation(int coins, int flips) {
    cout << "index,tails,heads,LargestTailStreak,LargestHeadStreak" << endl;
    for (int i = 1; i <= coins; i++) {
        flipper.Reset();
        cout << i << ",";
        SpamFlipTest(flips, true);
        flipper.Display();
    }
}

void ThreeHeadsObservation(int coins) {
    cout << "index,tails,LargestTailStreak,LargestHeadStreak" << endl;
    for (int i = 1; i <= coins; i++) {
        cout << i << ",";
        ThreeHeadsTest(true, false);
    }
}

int main(int argc, char* argv[] ) {
    if ( argc < 2 ) {
        cerr << "usage: ./name observation ...\n"
         << "       where observation = 0 or 1.\n"
        << "            when observation = 0: Spam Flip Observation\n"
        << "                   In this case, ... = int coins int flips\n"
        << "            when observation = 1: Three Heads Observation\n"
        "                   In this case, ... = int coins\n"
         << endl;
        exit( -1 );
    }
    int observation = atoi(argv[1]);

    //Spam flip observation
    if (observation == 0) {
        if (argc != 4) {
            cerr << "Missing Arguments" << endl;
            exit( -1 );
        }
        int coins = atoi(argv[2]);
        int flips = atoi(argv[3]);
        SpamFlipObservation(coins, flips);
        return 0;
    }

    //Three Heads Observation
    if (observation == 1) {
        if (argc != 3) {
            cerr << "Missing Arguments" << endl;
            exit( -1 );
        }
        int coins = atoi(argv[2]);
        ThreeHeadsObservation(coins);
        return 0;
    }

    //incorrect observation input
    cerr << "Invalid observation input. Observation must be either 0 or 1." << endl;
    exit( -1 );
}