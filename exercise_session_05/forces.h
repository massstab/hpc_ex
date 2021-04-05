#ifndef _FORCES
#define _FORCES

#include <vector>

struct particle {
        float x, y, z; // position 
        float vx, vy, vz; // velocity 
        float ax, ay, az; // acceleration
};

typedef std::vector<particle> particles;

void forces(particles &plist);

#endif