package LinkedList;
import java.util.Random;
import java.math.*;

// Number
// Created by Paul Kraft on 30.11.15.

public class Nummer {
	private int number;
	private static int POWER = 10;
	public Nummer() {
		this.number = (new Random()).nextInt((int)Math.pow(10.0,(double)(POWER)));
	}
	
	public String toString() {
		String a = number + "";
		while(a.length() < POWER)
		{
			 a = "0" + a;
		}
		return a;
	}
}