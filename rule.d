module rule;

import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.array;
import std.range;

alias BinaryRep = int[];
alias Rule = int[BinaryRep];
/**
* Creates a rule as a hashmap from a rule number
*/
Rule createRule(ulong neighbourhood_size)(ulong ruleNumber){
    auto ruleBinaryRep = binaryRep!((2^^neighbourhood_size))(ruleNumber).retro;
    int[int[]] result;

    for(int i = 0; i < ruleBinaryRep.length; i++){
        result[ (binaryRep!(neighbourhood_size)(i)).idup ] = ruleBinaryRep[i];
    }

    return result;
}

/**
* create the mirror rule of a rule
*/
Rule mirrorRule(Rule baseRule){
    int[int[]] result;

    foreach(v, k; baseRule){
        result[k.retro] = v;
    }

    return result;
}

/**
  * Binary representation of a number as an array of 0 and 1
  */
BinaryRep binaryRep(ulong bits_number)(ulong number){
    return format("%" ~ to!string(bits_number) ~ "b", number).replace(" ","0").map!(a => to!int(a) - to!int('0')).array;
}


/**
  * Decimal value of a binary value represented as an array of 0 and 1
  */
ulong decimalValue(BinaryRep rep){
    ulong value = 0;
    int i = 0;
    foreach(e; (rep.retro)){
        value += e * (2^^i);
        i++;
    }

    return value;
}

/**
  * Display a rule
  */
void printRule(size_t neighbourhood_size)(Rule rule){
    for(long i = 2^^neighbourhood_size - 1 ; i >= 0; i--){
        auto cellRep = binaryRep!(neighbourhood_size)(i.to!int);
        write( cellRep );
        write( " : " );
        writeln( rule[cellRep] );
    }
}