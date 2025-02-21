CC=gcc
CFLAGS=-I./include -I$(STAGING_INCDIR)/gpiod
LDFLAGS=

all: codec_control

codec_control.o: src/codec_control.c
	$(CC) $(CFLAGS) -c src/codec_control.c -o codec_control.o 

get_gpiochip_by_i2c_address.o: src/get_gpiochip_by_i2c_address.c
	$(CC) $(CFLAGS) -c src/get_gpiochip_by_i2c_address.c -o get_gpiochip_by_i2c_address.o

codec_control: codec_control.o get_gpiochip_by_i2c_address.o
	$(CC) codec_control.o get_gpiochip_by_i2c_address.o -o codec_control -lgpiod -Wl,--hash-style=gnu -Wl,-O1 -Wl,--as-needed

clean:
	rm -f *.o codec_control