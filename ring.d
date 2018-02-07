module ring;

import std.conv;
import std.array;

struct Ring(ContentType, size_t size){
    ContentType[size] _array;

    size_t modularIndex(size_t index){
        if(index >= 0){
            return index % _array.length;
        }
        else{
            return _array.length - (index % _array.length);
        }
    }

    ContentType opIndex(size_t index){
        return _array[modularIndex(index)];
    }

    ContentType opIndexAssign(ContentType value, size_t index){
        return _array[modularIndex(index)] = value;
    }

    string toString(){
        return _array.to!string();
    }

    ContentType[neighbourhood_size] neighbourhood
        (size_t neighbourhood_size)
        (int[] shifts, size_t element)
    {
        ContentType[neighbourhood_size] result;

        foreach(i, e; shifts){
            result[i] = this[element + e];
        }

        return result;
    }

    void applyRule(size_t neighbourhood_size)(ContentType[ContentType[]] rule, int[] shifts){
        ContentType[size] _buffer;

        for(size_t i = 0; i < size; i++){
            _buffer[i] = rule[this.neighbourhood!neighbourhood_size(shifts, i)];
        }

        _array = _buffer;
    }

    auto getNextStep(size_t neighbourhood_size)(ContentType[ContentType[]] rule, int[] shifts){
        Ring!(ContentType, size) _buffer = this;

        _buffer.applyRule!neighbourhood_size(rule, shifts);

        return _buffer;
    }

    auto rShift(size_t shift){
        Ring!(ContentType, size) _buffer;

        for(size_t i = 0; i < size; i++){
            _buffer[i] = this[i + shift];
        }

        return _buffer;
    }

    bool shiftEquals(Ring!(ContentType, size) r){
        for(size_t i = 0; i < size; i++){
            if( this == r.rShift(i) ) {
                return true;
            }
        }

        return false;
    }
}

string binaryRepresentation(size_t size)(Ring!(int, size) ca){
    auto app = appender!string();
    
    for(int i = 0; i < size; i++){
        if(ca[i] == 0){
            app.put("O");
        }
        else{
            app.put("X");
        }
    }

    return app.data;
}   
