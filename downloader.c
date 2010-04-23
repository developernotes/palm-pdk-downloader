
#include "PDL.h"
#include "SDL.h"
#include <stdio.h>
#include <curl/curl.h>

PDL_bool downloadFile(PDL_MojoParameters* parms) {
    int parameterCount = PDL_GetNumMojoParams(parms);
    if (parameterCount == 2) {
        const char* url = PDL_GetMojoParamString(parms, 1);
        const char* fileName = PDL_GetMojoParamString(parms, 2);

		CURL* curlHandle = curl_easy_init();
		if(curlHandle) {
			curl_easy_setopt(curlHandle, CURLOPT_URL, url);
			FILE* file = fopen(fileName, "w");
			curl_easy_setopt(curlHandle, CURLOPT_WRITEDATA, file);
			curl_easy_perform(curlHandle);		
			curl_easy_cleanup(curlHandle);
		}
        return PDL_TRUE;
    }
	return PDL_FALSE;
}

int main(int argc, char** argv) {
	printf("Hooking downloader into Mojo.");

	SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_NOPARACHUTE);
	PDL_RegisterMojoHandler("downloadFile", downloadFile);
	PDL_MojoRegistrationComplete();
	
	SDL_Event Event;
    do {
        while (SDL_PollEvent(&Event)) {
            switch (Event.type) {
                case SDL_KEYDOWN:
                    switch (Event.key.keysym.sym) {
                        case SDLK_ESCAPE:
                            Event.type = SDL_QUIT;
                            break;
							
                        default:
                            break;
                    }
                    break;
					
                default:
                    break;
            }
        }
		
    } while (Event.type != SDL_QUIT);
	
    SDL_Quit();
		return 0;
}
