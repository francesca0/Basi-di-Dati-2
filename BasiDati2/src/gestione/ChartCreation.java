package gestione;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.bson.Document;
import com.mongodb.BasicDBList;
import com.mongodb.MongoClient;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class ChartCreation {
	
	static MongoClient mongoClient = new MongoClient( "localhost" , 27017 );	
	static MongoDatabase data = mongoClient.getDatabase("db");
	static MongoCollection<Document> coll2 = data.getCollection("dbColl2");
	
	public static void main(String[] args) {
			    
		mongoClient.close();
	
	}

	public static ArrayList<ChartItem> createChart(BasicDBList gen, String annoDa, int range, String filtro, String axis, String operazione) {
		
	     	     
		//CASO GENERE se non metto il genere, prende tutti i campi con genres=true, cioè dove il genere esiste
	     Document genere = new Document();
	     
	     BasicDBList inArgs = new BasicDBList();
	     
	     if(gen!=null){
	        inArgs = gen;
	     }
	     
	     if(!gen.isEmpty() && !gen.get(0).toString().equals("")){
	    	 genere = new Document("$match",new Document("genres", new Document("$in",inArgs)));
	     }else{
	    	 genere = new Document("$match",new Document("genres", new Document("$exists",true)));
	     }
	     
	     //RAGGRUPPARE PER ANNO, PAESE, LINGUA	     
	     String trasformata=""; 
	     
	     if(operazione.equals("Somma")){
	    	 trasformata = "$sum";
	     }else if(operazione.equals("Media")){
	    	 trasformata = "$avg";
	     }else if(operazione.equals("Minimo")){
	    	 trasformata = "$min";
	     }else{
	    	 trasformata = "$max";
	     }
	     
	     if(axis.equals("Incasso")){
	    	 axis="gross";
	     }else{
	    	 axis = "budget";
	     }
	     
	     
	     Document part2 = new Document("_id",filtro);     
	     
	     
	     Document operazioneDocument= new Document(trasformata,"$"+axis+"");
    	 part2 = part2.append(axis, operazioneDocument);
    	 Document group = new Document("$group", part2);
    	 
    	 Document order = new Document("$sort",new Document("_id",1));
    	 
    	 String[] paesi = {"Italy","France","UK", "USA", "Germany", "China", "Russia", "Spain"};
    	 String[] lingue = {"Italian","French","English", "German", "Chinese", "Russian", "Spanish"};
    	 String[] pegi = {"T", "CA", "NR", "VM-14", "VM-18"};
    	 String[] vettoreFiltro;
    	 
    	 System.out.println("filtro "+filtro);
    	 if(filtro.equals("$country")){
    		vettoreFiltro = paesi; 
    	 }else if(filtro.equals("$language")){
     		vettoreFiltro = lingue; 
    	 }else{
    		 vettoreFiltro = pegi; 
    	 }

    	 int annoPartenza;
    	 Document anno;
    	 
    	 if(annoDa.isEmpty()){
     		annoPartenza = 2000;
     	 }else{
     		 annoPartenza=Integer.parseInt(annoDa);
     	 }
    	 
    	 ArrayList<ChartItem> el = new ArrayList<>();
    	 
    	 for(int j=0;j<5;j++){
 
    	ChartItem element = new ChartItem();
    	element.value= new ArrayList<>();
    	
    	
    	if(annoPartenza!= (annoPartenza+range-1)){
    		element.range=annoPartenza+"-"+(annoPartenza+range-1);
    	}else{
    		element.range=""+annoPartenza;
    	}
    	 anno = new Document("$match",new Document("title_year", new Document("$gte",annoPartenza).append("$lte", annoPartenza+range-1)));  
    	 
		   AggregateIterable<Document> iterable = coll2.aggregate(Arrays.asList(genere, anno, group, order));
		   
		   int i=0;
		   System.out.println(annoPartenza+"-"+(annoPartenza+range-1));
		   annoPartenza+=range;
		   for(String paese : vettoreFiltro){
			   
			   boolean aggiunto=false;
			   for (Document dbObject : iterable){
				   //se c'è
				   if(paese.equals(dbObject.get("_id"))){
					   element.value.add((long) Double.parseDouble(dbObject.get(axis).toString()));
					   aggiunto=true;
					   	System.out.println(++i+"-----"+dbObject.get("_id")+"----"+dbObject.get(axis));	
				   }
			   }
			   if(!aggiunto){
				   element.value.add(Long.parseLong("0"));
			   }
		    }
		   
		   el.add(element);
		   System.out.println(element.value.toString());
    	 }
	   
	       return el;
	  }

	
	public static BasicDBList prendiGenere(List<String> genere){
		 BasicDBList inArgs = new BasicDBList();
		 
		 for(int i=0; i<genere.size();i++){
	        inArgs.add(genere.get(i).toString());
		 }
		 
		 return inArgs;
	}
		
}
		
		
	
