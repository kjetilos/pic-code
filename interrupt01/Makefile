NAME=interrupt01

$(NAME).hex: $(NAME).o
	gplink -m $^ -o $@

%.o: %.asm
	gpasm -c $^ -o $@

dasm: $(NAME).hex
	gpdasm -p 12f675 $^

upload: $(NAME).hex
	sudo /home/kos/bin/usb_pickit --program=$(NAME).hex

.PHONY: upload, clean

clean:
	rm -f *.o *.hex *.lst *.cod *.map
