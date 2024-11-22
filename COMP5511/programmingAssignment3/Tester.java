package COMP5511.programmingAssignment3;

import COMP5511.dataStructures_textbook.DefaultComparator;

public class Tester {

    public static void main(String[] args) {
        DefaultComparator<Integer> comp = new DefaultComparator<Integer>();

        AFPriorityQueue<Integer, String> afpq = new AFPriorityQueue<>(comp);
        
        AFPQEntry<Integer, String> first = afpq.insert(7, "A");
        AFPQEntry<Integer, String> second = afpq.insert(2, "B");
        AFPQEntry<Integer, String> third = afpq.insert(3, "C");
        afpq.insert(0, "P");
        afpq.insert(4, "D");
        afpq.insert(1, "F");
        afpq.insert(5, "G");
        afpq.insert(6, "H"); 
        
        // testing null value insertion
        // afpq.insert(6, null);        


        System.out.println("-----INITIAL STATE-----");
        System.out.println("STATE: " + afpq.state());
        System.out.println("EMPTY?: " + afpq.isEmpty());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        
        System.out.println();
        System.out.println("TOGGLE FROM: " + afpq.state());
        afpq.toggle(); 
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());
        
        System.out.println();
        System.out.println("TOGGLE FROM: " + afpq.state()); 
        afpq.toggle();
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());                
        
        System.out.println();
        System.out.println("OLD VALUE REPLACED: " + afpq.replaceValue(first, "10"));
        System.out.println("NEW AFPQ: " + afpq.toString());
        System.out.println("REMOVE TOP: " + afpq.removeTop());
        System.out.println("-----AFTER REMOVE TOP-----");
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        
        System.out.println();
        System.out.println("REPLACED KEY: " + afpq.replaceKey(third, 4));
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());


    }
    
}
