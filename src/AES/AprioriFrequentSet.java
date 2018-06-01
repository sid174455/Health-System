package AES;


import java.util.*;
import java.util.Map.Entry;

public class AprioriFrequentSet<E> {

//    public static void main(String[] args) {
//    	
//    }
    
    public static String getdata(String string1){
    	Map<String, Integer> unique = new HashMap<String, Integer>();
        
        for (String string : string1.split(",")) {
            if (unique.get(string) == null) {
                unique.put(string, 1);
            } else {
                unique.put(string, unique.get(string) + 1);
                System.out.println("there is plus string"+string);
            }
        }        
       
        String uniqueString = join(unique.keySet(), ",");
        List<Integer> value = new ArrayList<Integer>(unique.values());
//        System.out.println("Output = " + unique);
//        System.out.println("Output = " + uniqueString);
//        System.out.println("Values = " + value);
        String tagid = "";
        for(int i=0;i<unique.size();i++)
        {
        	String data=entriesSortedByValues(unique).get(i).toString();
	    
		    String[] divisions = data.split("=");
		    tagid = tagid +","+divisions[0].replaceAll(" ", "");
	        //System.out.println(tagid);
        }
		return tagid;
    	
    }

    public static String join(Collection<String> s, String delimiter) {
        StringBuffer buffer = new StringBuffer();
        Iterator<String> iter = s.iterator();
        while (iter.hasNext()) {
            buffer.append(iter.next());
            if (iter.hasNext()) {
                buffer.append(delimiter);
            }
        }
        return buffer.toString();
    }
    
	    static <K,V extends Comparable<? super V>> 
	    List<Entry<K, V>> entriesSortedByValues(Map<K,V> map) {
		
		List<Entry<K,V>> sortedEntries = new ArrayList<Entry<K,V>>(map.entrySet());
		
		Collections.sort(sortedEntries, 
		    new Comparator<Entry<K,V>>() {
		        @Override
		        public int compare(Entry<K,V> e1, Entry<K,V> e2) {
		            return e2.getValue().compareTo(e1.getValue());
		        }
		    }
		);
		
		return sortedEntries;
	
	}
}
