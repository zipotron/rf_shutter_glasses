all : stereoscopic

stereoscopic : stereoscopic.c
	gcc stereoscopic.c -o stereoscopic -lc -lm -lgcc -lpthread -ldrm -lcairo -lkms -I /usr/include/libdrm -I /usr/include/libkms -I /usr/include/cairo

clean :
	-rm stereoscopic
