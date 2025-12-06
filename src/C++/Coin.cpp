//
// Created by Ismail Shalanfeh on 12/2/25.
//

#include <random>
#include "pcg_random.hpp"
#include "pcg_extras.hpp"

using namespace std;

class Coin {
  public:
    pcg32* rng;

    int tails = 0;
    int heads = 0;
    int tailStreak = 0;
    int headStreak = 0;
    int LargestHeadStreak = 0;
    int LargestTailStreak = 0;

    Coin() {
      rng = new pcg32();
    }

    Coin(uint64_t seed) {
      rng = new pcg32(seed);
    }

    ~Coin() {
        delete rng;
     }

  void Reseed(uint64_t seed) {
      delete rng;
      rng = new pcg32(seed);
    }

  void Reset() {
      tails = 0;
      heads = 0;
      tailStreak = 0;
      headStreak = 0;
      LargestHeadStreak = 0;
      LargestTailStreak = 0;
    }

    //true = heads, false = tails
    bool Flip() {
      double RandomNumber = (generate_canonical<double, 32>(*rng) * 100); //[0, 100)
      double threshold = 50 + (tailStreak * 2.5); //base + 2.5 for each tails in a row
      //double threshold = 50; //base

      //tails case
      if (RandomNumber > threshold) {
        tails += 1;
        tailStreak += 1;
        headStreak = 0;
        if (tailStreak > LargestTailStreak) {
          LargestTailStreak = tailStreak;
        }

        return false;
      }

      //heads case (RandomNumber <= threshold)
      heads += 1;
      headStreak += 1;
      tailStreak = 0;
      if (headStreak > LargestHeadStreak) {
        LargestHeadStreak = headStreak;
      }

      return true;
    }

  void Display() {
      cout << tails << "," << heads << "," << LargestTailStreak << "," << LargestHeadStreak << endl;
    }

  void DisplayNoHeads() {
      cout << tails << "," << LargestTailStreak << "," << LargestHeadStreak << endl;
    }

};