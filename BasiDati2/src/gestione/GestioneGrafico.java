package gestione;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mongodb.BasicDBList;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;

@WebServlet("/GestioneGrafico")
public class GestioneGrafico extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings( "deprecation" )Mongo mongoClient = new Mongo( "localhost" , 27017 );
	@SuppressWarnings( "deprecation" )DB database = mongoClient.getDB("db");
	DBCollection table = database.getCollection("dbColl2");
	HttpSession session=null;    
 
    public GestioneGrafico() {
        super();
    }
    
    public GestioneGrafico(String str) {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String annoDa="";
		List<String> listaGenere =null;
		BasicDBList bdo = null;
		String[] genere = request.getParameterValues("genere");
		int range=Integer.parseInt(request.getParameter("range"));
		String filtro = Arrays.asList(request.getParameterValues("gruppo1")).get(0);	
		String axis = request.getParameter("axis");
		String operazione = request.getParameter("operazione");
		ArrayList<ChartItem> arrayListChartItem = new ArrayList<>();
		
		if(request.getParameter("daField") != null){
			annoDa = request.getParameter("daField");
		}
		
		if(genere !=null){
			listaGenere = Arrays.asList(genere);
			bdo = Aggregation.prendiGenere(listaGenere);

		}else{
			listaGenere = Arrays.asList("");
			bdo = Aggregation.prendiGenere(listaGenere);
		}
		
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
		
	
		arrayListChartItem = ChartCreation.createChart(bdo ,annoDa, range, filtro, axis, operazione);
		request.setAttribute("arrayListChartItem", arrayListChartItem);
		request.setAttribute("filterVector", vettoreFiltro);
        
		RequestDispatcher rd = request.getRequestDispatcher("grafico.jsp");
		rd.forward(request, response);


		//doGet(request, response);
		mongoClient.close();
	}

}
