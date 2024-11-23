package COMP5511.programmingAssignment3;

public class Tester {

    public static void main(String[] args) {
        AFPriorityQueue<Integer, String> afpq = new AFPriorityQueue<>();
        
        AFPQEntry<Integer, String> first = afpq.insert(1, "A");
        AFPQEntry<Integer, String> second = afpq.insert(2, "B");
        AFPQEntry<Integer, String> third = afpq.insert(3, "C");
        AFPQEntry<Integer, String> fourth = afpq.insert(4, "D");
        AFPQEntry<Integer, String> fifth = afpq.insert(5, "C");
        AFPQEntry<Integer, String> sixth = afpq.insert(0, "P");
        afpq.insert(7, "G");
        afpq.insert(6, "H"); 


        System.out.println("-----INITIAL STATE-----");
        System.out.println("STATE: " + afpq.state());
        System.out.println("EMPTY?: " + afpq.isEmpty());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        
        System.out.println();
        System.out.println("-----TOGGLE-----");
        System.out.println("TOGGLE FROM: " + afpq.state());
        afpq.toggle(); 
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());
        
        System.out.println();
        System.out.println("-----TOGGLE-----");
        System.out.println("TOGGLE FROM: " + afpq.state()); 
        afpq.toggle();
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());                
        
        System.out.println();
        String newValue = "Z";
        System.out.println("-----REPLACE VALUE-----");
        System.out.println("OLD VALUE: " + afpq.replaceValue(second, newValue) + " , REPLACED WITH: " + newValue);
        System.out.println("NEW AFPQ: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("REMOVE TOP: " + afpq.removeTop());


        System.out.println();
        System.out.println("-----AFTER REMOVE TOP-----");
        System.out.println("STATE: " + afpq.state());
        System.out.println("SIZE: " + afpq.size());
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        
        System.out.println();
        int key1 = 12;
        System.out.println("-----REPLACE KEY-----");
        System.out.println("OLD KEY: " + afpq.replaceKey(third, key1) + " , REPLACED WITH: " + key1);
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        int key2 = 13;
        System.out.println();
        System.out.println("-----REPLACE KEY-----");
        System.out.println("OLD KEY: " + afpq.replaceKey(fourth, key2) + " , REPLACED WITH: " + key2);
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        
        System.out.println();
        System.out.println("-----REMOVE ANY ENTRY-----");
        System.out.println("STATE: " + afpq.state());        
        System.out.println("OLD ENTRY: " + afpq.remove(fifth));
        System.out.println("AFTER ENTRY REMOVAL: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        afpq.insert(7, "F");
        afpq.insert(8, "I");
        afpq.insert(9, "J");
        afpq.insert(10, "K");
        
        System.out.println();
        System.out.println("-----NEW INSERTIONS-----");
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOGGLE FROM: " + afpq.state()); 
        afpq.toggle();
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());                
        
        System.out.println();
        System.out.println("-----REMOVE ANY ENTRY-----");
        System.out.println("STATE: " + afpq.state());        
        System.out.println("OLD ENTRY: " + afpq.remove(first));
        System.out.println("AFTER ENTRY REMOVAL: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());

        // --- ERROR-HANDLING ---

        // testing null value insertion
        // afpq.insert(6, null);       
        // afpq.insert(null, "H"); 
        
        // System.out.println("\n-----REMOVE NON-EXISTANT KEY-----");
        // AFPQEntry<Integer, String> nonExistantEntry = new AFPQEntry<Integer, String>(99,"NonExistant");
        // System.out.println("OLD ENTRY: " + afpq.remove(nonExistantEntry));
        // System.out.println("AFPQ: " + afpq.toString());
    }
    
}
