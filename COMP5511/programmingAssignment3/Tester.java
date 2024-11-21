package COMP5511.programmingAssignment3;

import COMP5511.dataStructures_textbook.DefaultComparator;

public class Tester {

    public static void main(String[] args) {
        DefaultComparator<Integer> comp = new DefaultComparator<Integer>();

        AFPriorityQueue<Integer, String> afpq = new AFPriorityQueue<>(comp);
        
        AFPQEntry<Integer, String> first = afpq.insert(7, "7");
        AFPQEntry<Integer, String> second = afpq.insert(2, "2");
        afpq.insert(3, "3");
        afpq.insert(4, "4");
        afpq.insert(1, "1");
        afpq.insert(5, "5");
        afpq.insert(6, "6");        


        System.out.println("-----INITIAL STATE-----");
        System.out.println("STATE: " + afpq.state());
        System.out.println("EMPTY?: " + afpq.isEmpty());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());

        System.out.println("OLD VALUE REPLACED: " + afpq.replaceValue(first, "10"));
        System.out.println("NEW AFPQ: " + afpq.toString());

        System.out.println("REMOVE TOP: " + afpq.removeTop());
        System.out.println("-----AFTER REMOVE TOP-----");
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());


    }
    
}
