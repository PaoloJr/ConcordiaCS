package COMP5511.programmingAssignment3;

import COMP5511.dataStructures_textbook.DefaultComparator;

public class Tester {

    public static void main(String[] args) {
        DefaultComparator<Integer> comp = new DefaultComparator<Integer>();

        AFPriorityQueue<Integer, String> afpq = new AFPriorityQueue<>();
        AFPriorityQueue<Integer, String> afpq2 = new AFPriorityQueue<>(comp);

        // AFPQEntry<Integer, String> entry = new AFPQEntry<>();
        
        afpq.insert(7, "7");
        afpq.insert(2, "2");
        afpq.insert(3, "3");
        afpq.insert(4, "4");
        afpq.insert(1, "1");
        afpq.insert(5, "5");
        afpq.insert(6, "6");


        System.out.println("STATE: " + afpq.state());
        System.out.println("EMPTY?: " + afpq.isEmpty());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        System.out.println("REMOVE TOP: " + afpq.removeTop());
        System.out.println("-----AFTER REMOVE TOP-----");
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());


        // System.out.println("STATE: " + afpq2.state());
        // System.out.println("EMPTY?: " + afpq2.isEmpty());
        // System.out.println("SIZE: " + afpq2.size());
        // System.out.println("AFPQ: " + afpq2.toString());
        // System.out.println("TOP: " + afpq2.top());
        // System.out.println("REMOVE TOP: " + afpq2.removeTop());
        // System.out.println("SIZE: " + afpq2.size());
        // System.out.println("AFPQ: " + afpq2.toString());
    }
    
}
