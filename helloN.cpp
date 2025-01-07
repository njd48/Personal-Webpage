
#include <iostream>
#include <cstdlib> 

using namespace std;

int main(int argc, char** argv){

if (argc != 2){
	cout << "oh shit, thats not the right number of arguments\n";
	return 0;
};

int Num = atoi( argv[1] );

	for(int i=0; i<Num; i++){

		cout << "["<< i <<"] Hello World\n";

	}
}
