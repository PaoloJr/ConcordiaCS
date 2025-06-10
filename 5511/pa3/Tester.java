public class Tester {

    @SuppressWarnings("unused")
    public static void main(String[] args) {
        AFPriorityQueue<Integer, String> afpq = new AFPriorityQueue<>();

        // testing `top()` function when heap is empty
        // System.out.println("TOP: " + afpq.top());
        
        AFPQEntry<Integer, String> first = afpq.insert(1, "A");
        AFPQEntry<Integer, String> second = afpq.insert(2, "B");
        AFPQEntry<Integer, String> third = afpq.insert(3, "C");
        AFPQEntry<Integer, String> fourth = afpq.insert(4, "D");
        AFPQEntry<Integer, String> fifth = afpq.insert(5, "E");
        AFPQEntry<Integer, String> sixth = afpq.insert(6, "F");
        AFPQEntry<Integer, String> seventh = afpq.insert(7, "G");
        AFPQEntry<Integer, String> eighth = afpq.insert(8, "H"); 

        // sanityCheck
        // afpq.sanityCheck();

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
        System.out.println("TOP: " + afpq.top());
        
        System.out.println();
        System.out.println("-----TOGGLE-----");
        System.out.println("TOGGLE FROM: " + afpq.state()); 
        afpq.toggle();
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());                
        System.out.println("TOP: " + afpq.top());
        
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
        int key1 = 15;
        System.out.println("-----REPLACE KEY-----");
        System.out.println("OLD KEY: " + afpq.replaceKey(third, key1) + " , REPLACED WITH: " + key1);
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        System.out.println();
        int key2 = 16;
        System.out.println("-----REPLACE KEY-----");
        System.out.println("OLD KEY: " + afpq.replaceKey(fourth, key2) + " , REPLACED WITH: " + key2);
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        
        System.out.println();
        System.out.println("-----REMOVE ANY ENTRY-----");
        System.out.println("STATE: " + afpq.state());        
        System.out.println("REMOVED ENTRY: " + afpq.remove(fifth));
        System.out.println("AFTER ENTRY REMOVAL: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        afpq.insert(9, "I");
        afpq.insert(10, "J");
        afpq.insert(11, "K");
        afpq.insert(12, "L");

         // sanityCheck
        //  afpq.sanityCheck();
        
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
        System.out.println("REMOVED ENTRY: " + afpq.remove(eighth));
        System.out.println("AFTER ENTRY REMOVAL: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        System.out.println();
        int key3 = 17;
        System.out.println("-----REPLACE KEY-----");
        System.out.println("OLD KEY: " + afpq.replaceKey(sixth, key3) + " , REPLACED WITH: " + key3);
        System.out.println("AFTER REPLACE KEY: " + afpq.toString());
        System.out.println("SIZE: " + afpq.size());
        
        System.out.println();
        String newValue1 = "NewNew";
        System.out.println("-----REPLACE VALUE AFTER REPLACING KEY-----");
        System.out.println("OLD VALUE: " + afpq.replaceValue(sixth, newValue1) + " , REPLACED WITH: " + newValue1);
        System.out.println("NEW AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        System.out.println("SIZE: " + afpq.size());
        
        System.out.println();
        System.out.println("-----TOGGLE-----");
        System.out.println("TOGGLE FROM: " + afpq.state()); 
        afpq.toggle();
        System.out.println("TOGGLE TO: " + afpq.state()); 
        System.out.println("AFPQ AFTER TOGGLE: " + afpq.toString());  
        System.out.println("SIZE: " + afpq.size());
        System.out.println("REMOVE TOP: " + afpq.removeTop());    
        System.out.println("AFPQ: " + afpq.toString());
        System.out.println("TOP: " + afpq.top());
        System.out.println("SIZE AFTER REMOVETOP: " + afpq.size());
        System.out.println();

        // sanityCheck
        //  afpq.sanityCheck();     
        
        // --- ERROR-HANDLING ---
        
        // testing null key or value on insertion
        // afpq.insert(6, null);       
        // afpq.insert(null, "H");         

        // testing removal of non-existant entry
        // System.out.println("-----REMOVE NON-EXISTANT ENTRY-----");
        // System.out.println("STATE: " + afpq.state());        
        // System.out.println("REMOVED ENTRY: " + afpq.remove(eighth));
        // System.out.println("AFTER ENTRY REMOVAL: " + afpq.toString());
        // System.out.println("SIZE: " + afpq.size());

        // AFPQEntry<Integer, String> nonExistantEntry = new AFPQEntry<Integer, String>(99,"NonExistant");
        // System.out.println("REMOVED ENTRY: " + afpq.remove(nonExistantEntry));

        
        // testing replacement of non-existant key
        // int key4 = 18;
        // System.out.println("-----REPLACE NON-EXISTANT KEY-----");
        // System.out.println("OLD KEY: " + afpq.replaceKey(first, key4) + " , REPLACED WITH: " + key4);
        // System.out.println("AFTER REPLACE KEY: " + afpq.toString());     
        
    }
    
}
