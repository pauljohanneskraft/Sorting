package LinkedList;
import java.util.*;

//
// Sort
// Created by Paul Kraft on 03.12.15.

public abstract class Sort<T> extends Thread {
	abstract <T> void sort(LinkedList<T> liste);
}