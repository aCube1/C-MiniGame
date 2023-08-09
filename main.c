#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // Para usleep() em sistemas Unix-like
        

int main(int argc, char *argv[]) {
	Start();
	while(1){
		Update();
        usleep(16667); // 1 segundo = 1000000 microssegundos, 1000000 / 60 ˜ 16667
	}
	
	return 0;
}

void Start(){

}

void Update(){

}
