/*
 * Assignment 2B C code.c
 *
 * Created: 3/9/2019 3:59:29 PM
 * Author : Mat Tomljenovic
 */ 
	#define F_CPU 8000000UL
	#include <avr/io.h>
	#include <avr/interrupt.h>
	#include <util/delay.h>
	int main()
	{
		DDRB = (1 << PB5); //PB5 as an output
		PORTD = 1<<2;      //pull-up activated
		EICRA = 0x2;       //make INT0 falling edge triggered
		EIMSK = (1<<INT0); //enable external interrupt 0
		sei();             //enable interrupts
		while(1);          //wait here
		{
			PORTB = 0x00; //turn LED off
		}
		
	}
	ISR (INT0_vect) //ISR for external interrupt 0
	{
		PORTB ^= (1<<5); //toggle PORTB5
		_delay_ms(150);  //delay of 1.2 sec
	}

