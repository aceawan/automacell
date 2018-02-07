module ca;

import ring;
import std.algorithm;
import std.conv;
import std.stdio;

struct CA(ContentType, size_t size){
	Ring!(ContentType, size) _ring;
	bool[ContentType[]] visited;
	public bool isLooping = false;
	public bool isSynchronized = false;

	alias _ring this;

	void applyRule(size_t neighbourhood_size)(ContentType[ContentType[]] rule, int[] shifts){
        ContentType[] _buffer;

        _buffer.length = size;

        for(size_t i = 0; i < size; i++){
            _buffer[i] = rule[this.neighbourhood!neighbourhood_size(shifts, i)];
        }

        // Check for looping
        if(_buffer in visited) {
        	this.isLooping = true;
        }
        else {
        	visited[_buffer.idup] = true;
        }

        // Check for sync (only works on binary ECA)
        if(sum(_buffer) == size && sum(_array.idup) == 0){
        	this.isSynchronized = true;
        }
        else if(sum(_buffer) == 0 && sum(_array.idup) == size){
        	this.isSynchronized = true;
        }

        _array = _buffer;
    }
}

