led01.hex: led01.asm
	gpasm $^ -o $@
	#link -m $^ -o $@

#%.o: %.asm
#	gpasm -c $^ -o $@

#traffic.hex: traffic.asm
#	gpasm traffic.asm

dasm: led01.hex
	gpdasm -p 12f675 $^

upload: led01.hex
	sudo /home/kos/bin/usb_pickit --program=led01.hex

.PHONY: upload

clean:
	rm -f *.o *.hex *.lst *.cod *.map