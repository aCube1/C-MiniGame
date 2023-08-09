// Librarys
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <conio.h> // Para detecção de teclas no Windows

// Start script
int main(int argc, char *argv[]) {
	Start();
	while(1){
		system("cls");
		Update();
		
		
        usleep(16667); // 1 segundo = 1000000 microssegundos, 1000000 / 60 ˜ 16667
	}
	
	return 0;
}

// Game Values

// X / Y
int playerPosition[2] = {0,2};
// witdh / height
int screenZone[2] = {100, 25};

char playerSkin = '0';

// General Values

int i;

// Global commands

void Start(){
	
}

void Update(){
	
	PlayerMovementation();
	WritePlataforms();
	InputManager();
	PlayerGravity();
	
}


// Game commands 

/// Player Inputs
void InputManager(){
	if (_kbhit()) {
        char input = _getch();
		if (input == 'a') {
			Translate(-1, 0);
		}
		if (input == 'd') {
			Translate(1, 0);
		}	
		if (input == 'w') {
			Translate(0, -1);
		}
		if (input == 's') {
			Translate(0, 1);
		}
	}

}

/// PLAYER
void PlayerMovementation(){
	int Yposition = screenZone[1] - playerPosition[1];
	
	for(i = 0; i < playerPosition[1]; i ++){
		printf("\n");
	}
	
	for(i = 0; i < playerPosition[0] - 1; i++){
		printf(" ");
	}
	
	printf("%c", playerSkin);
	
	for(i = 0; i < Yposition; i ++){
		printf("\n");
	}
}

void Translate(int x, int y){
    int newPositionX = playerPosition[0] + x;
    int newPositionY = playerPosition[1] + y;

    if(newPositionX <= screenZone[0] && newPositionX > 0){
        playerPosition[0] = newPositionX;
    }

    if(newPositionY <= screenZone[1] && newPositionY > 0){
        playerPosition[1] = newPositionY;
    }
}

void PlayerGravity(){
	Translate(0, 1);
}

void PlayerCollider(){
	
}

/// Plataforms
void WritePlataforms(){
	printf("------------------------------------------------------------");
}


