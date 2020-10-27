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

public class Aggregation {

	static MongoClient mongoClient = new MongoClient( "localhost" , 27017 );	
	static MongoDatabase data = mongoClient.getDatabase("db");
	static MongoCollection<Document> coll2 = data.getCollection("dbColl2");
	
	public static void main(String[] args) {
			    
		mongoClient.close();
	
	}
	
	public static ArrayList<String> lanciaGroup(BasicDBList gen, String annoA, String annoDa,BasicDBList radio , List<String> listaAltriCampi, String operazione){
	    
		 int i=0;  
	     BasicDBList inArgs = new BasicDBList();
	     
	     if(gen!=null){
	        inArgs = gen;
	     }
	     	     
	     //CASO ANNO se sono entrambi vuoti prendi tutti quelli che hanno anno>0 (cioè tutti)
	     Document anno = new Document("$match",new Document("title_year", new Document("$gte",0)));

	     if(annoA.isEmpty() && !annoDa.isEmpty()){
	    	 anno = new Document("$match",new Document("title_year", new Document("$gte",Integer.parseInt(annoDa))));
	     }
	     else if(annoDa.isEmpty() && !annoA.isEmpty()){
	    	 anno = new Document("$match",new Document("title_year", new Document("$lte",Integer.parseInt(annoA))));
	     }
	     else if(!annoDa.isEmpty() && !annoA.isEmpty()){
	    	 anno = new Document("$match",new Document("title_year", new Document("$gte",Integer.parseInt(annoDa)).append("$lte", Integer.parseInt(annoA))));
	     }
	     
	     //CASO GENERE se non metto il genere, prende tutti i campi con genres=true, cioè dove il genere esiste
	     Document genere = new Document();
	     
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
	     
	     Document operazioneDocument= new Document();
	     Document part2 = new Document("_id",radio.get(0).toString());     
	     ArrayList<String> arr = new ArrayList<>();
	     Document group = new Document();
	     
	     
	     
	     if(listaAltriCampi != null){
	    	
		     for(i=0;i<listaAltriCampi.size();i++){
		    	 operazioneDocument= new Document(trasformata,"$"+listaAltriCampi.get(i).toString()+"");
		    	 part2 = part2.append(listaAltriCampi.get(i).toString(), operazioneDocument);
		    	 arr.add(listaAltriCampi.get(i).toString());
		     }
	     	     
		 }

	     group = new Document("$group", part2);
	     
	   AggregateIterable<Document> iterable = coll2.aggregate(Arrays.asList(genere, anno, group));
	   String daStampare = radio.get(0).toString().substring(1, radio.get(0).toString().length());
	    
	    i=0;
	    String testa="";
	    String coda="";
	    
	    testa+="<tr> <th scope='col'>"+ daStampare+ "</th>";
	    for(int j=0;j<arr.size();j++){
	    	testa+="<th scope='col'>"+ arr.get(j)+ "</th>";
	    }
	    testa+="</tr>";
	    		
	    for (Document dbObject : iterable)
	    {
	    	coda+="<tr> <td>"+ dbObject.get("_id")+ "</td>";
	    	
	    	for(int j=0;j<arr.size();j++){
	    		double v = Math.round(Double.parseDouble(dbObject.get(arr.get(j)).toString())*100);
	    	    
	    		coda+="<td>"+ v/100 +"</td>";
	    	}

	    	coda+="</tr>";
	        i++;
	    }
	    
	    //send table to jsp
	    ArrayList<String> p = new ArrayList<>();
	    p.add(testa);
	    p.add(coda);
	    return p;
	    
	     
	  }

	
	public static BasicDBList prendiGenere(List<String> genere){
		 BasicDBList inArgs = new BasicDBList();
		 
		 for(int i=0; i<genere.size();i++){
	        inArgs.add(genere.get(i).toString());
		 }
		 
		 return inArgs;
	}
}
