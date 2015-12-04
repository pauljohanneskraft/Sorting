package SortingAlgs;
import java.util.Random;
import java.math.*;

// Number
// Created by Paul Kraft on 30.11.15.

public class Number {
	private int number;
	private static int POWER = 10;
	public Number()
	{
		this.number = (new Random()).nextInt((int)Math.pow(10.0,(double)(POWER)));
	}
	
	public String toString()
	{
		String a = number + "";
		while(a.length() < POWER)
		{
			 a = "0" + a;
		}
		return a;
	}
}