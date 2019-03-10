;
; Assignment 2B Amb Code.asm
;
; Created: 3/9/2019 5:31:55 PM
; Author : Mat Tomljenovic
;


	
	
	
	.ORG 0
	JMP MAIN
	.ORG 0x02
	JMP EX0_ISR
	MAIN:
		LDI R20,HIGH(RAMEND) //load high bit of end ram into R20
		OUT SPH,R20          //outputting R20 value into stack pointer high
		LDI R20,LOW(RAMEND)  //load low bit of end ram into R20
		OUT SPL, R20         //output R20 value into stack pointer low
		LDI R20,0x02         //load 0x02 into R20/ make falling edge triggered
		STS EICRA,R20        //store one byte from R20 into EICRA
		SBI DDRB, 5			 //make PB5 output
		SBI PORTD, 2		 //make oin D2 input
		LDI R20,1<<INT0      //enable INT0
		OUT EIMSK, R20		 //output R20 into mask register
		SEI					 //enable interrupts

	HERE:
		JMP HERE            //jump to HERE label
		EX0_ISR:			//loop label
		IN R21,PORTB		//input value for R21 into PORTB
		LDI R22,(1<<5)		//shift value in R22 by 5. to toggle PB5
		EOR R21,R22			//exclusive or value in R22 and R21
		RCALL DELAY_1s		//call delay loop of 1 sec
		RCALL DELAY_100ms	//call dellay loop of 100 mili seconds
		RCALL DELAY_100ms
		RCALL DELAY_5ms		//call delay loop of 5 mili seconds
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		RCALL DELAY_5ms
		OUT PORTB,R21		//output value of R21 into PORTB
		RETI				//return from interrupt

		
		DELAY:				//delay label
		DELAY_1S:			//dealay_1s label
		PUSH R16			//stores value in R16 on the stack
		LDI R16,200			//load 200 into R16
		DELAY_1S1:			//DELAY_1S1 label
		RCALL DELAY_5MS		//call DELAY loop
		DEC R16				//decriment vlaue in R16
		BRNE DELAY_1S1		//branch if not equal to DELAY_1S1
		POP R16				//loads R16 with vlaue form stack
		RET					//return to function


		DELAY_100MS:		//Delay label
		PUSH R16			//stores value in R16 on the stack
		LDI R16,100			//load 100 into R16
		DELAY_100MS1:		//Dealy label
		RCALL DELAY_1MS		//call delay loop
		DEC R16				//decriment value in R16
		BRNE DELAY_100MS1	//branch if not equal to delay loop
		POP R16				//loads R16 with value from stack
		RET					//return to function

		DELAY_5MS:			//delay label
		RCALL DELAY_1MS		//call 1 milisecond delay fucntion
		RCALL DELAY_1MS		
		RCALL DELAY_1MS
		RCALL DELAY_1MS
		RCALL DELAY_1MS
		RET


		DELAY_1MS:			//delay label
		PUSH R16			//stores value in R16 to stack
		LDI R16,99			//load 99 in R16
		DELAY_1MS1:			//delay label
		NOP					//no operation
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		DEC R16				//decriment value in R16
		BRNE DELAY_1MS1		//branch if not equal to delay loop
		POP R16				//laods R16 with value from stack pointer
		RET					//return to function



