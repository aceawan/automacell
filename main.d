module init_recherche;

import ring;
import rule;
import ca;
import std.stdio;

// Détermine quelles règles transforment 000001 en la même chose à un décalage près
/*
void main(){
    enum neighbourhood_size = 5;
    enum neighbourhood_shifts = [-2,-1,0,1,2];

    ulong j = 0;

    foreach(i ; 0 .. 2uL^^(2uL^^neighbourhood_size)){
        if(i % 10000 == 0){
            writefln("Test de %d", i);
        }
        Ring!(int, 6) r;
        int[int[]] rule = createRule!neighbourhood_size(i);

        r._array = [0,0,0,0,0,1];

        if(r.getNextStep!neighbourhood_size(rule, neighbourhood_shifts).shiftEquals(r)){
            //writefln("rule : %d", i);
            j++;
        }
    }

    writeln(j);
}
*/

// Execute a given automata until it's synchronized
/*
void main(){
    enum neighbourhood_size = 3;
    enum ring_size = 6;
    enum neighbourhood_shifts = [-1,0,1];
    CA!(int, ring_size) ca;
    ca._array = [1,0,1,0,1,1];

    auto rule = createRule!neighbourhood_size(0b01101001);

    while(!ca.isSynchronized){
        writeln(ca);
        ca.applyRule!neighbourhood_size(rule, neighbourhood_shifts);
    }

    writeln(ca);
}
*/

void main(){
    int[6] test = [1,2,3,4,5,6];

    writeln(sumStaticArray(test));
}

int sumStaticArray(size_t size)(int[size] arr){
    int acc = 0;

    foreach(e; arr){
        acc += e;
    }

    return acc;
}