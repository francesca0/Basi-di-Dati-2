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
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;

@WebServlet("/GestioneDatiServlet")
public class GestioneDatiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings( "deprecation" )Mongo mongoClient = new Mongo( "localhost" , 27017 );
	@SuppressWarnings( "deprecation" )DB database = mongoClient.getDB("db");
	DBCollection table = database.getCollection("dbColl");
	DBCursor cursor = null;	
	BasicDBObject whereQuery = new BasicDBObject();
	List<BasicDBObject> obj = new ArrayList<BasicDBObject>();
	HttpSession session=null;    
	BasicDBList bdo = null, dbo2=null;
	Aggregation aggregation = null;
 
    public GestioneDatiServlet() {
        super();
    }
    
    public GestioneDatiServlet(String str) {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> listaGenere =null;
		List<String> listaAltriCampi = null;
		List<String> listaRadioButton = null;
		String annoDa="",annoA="";
		String[] genere = request.getParameterValues("genere");
		String[] filtro = request.getParameterValues("gruppo1");
				
		
		if(request.getParameter("daField") == null){
			 annoDa="";
		}else{
			annoDa = request.getParameter("daField");
		}
		
		if(request.getParameter("aField") == null){
			 annoA="";
		}else{
			annoA = request.getParameter("aField");

		}
		if(genere !=null){
			listaGenere = Arrays.asList(genere);
			bdo = Aggregation.prendiGenere(listaGenere);

		}else{
			listaGenere = Arrays.asList("");
			bdo = Aggregation.prendiGenere(listaGenere);
		}
		if(filtro != null){
			listaRadioButton = Arrays.asList(filtro);
			dbo2 = Aggregation.prendiGenere(listaRadioButton);
		}
		
		String altroArray[] = request.getParameterValues("altro");
		
		if(altroArray !=null){
			listaAltriCampi = Arrays.asList(altroArray);
		}
		
		String operazione = request.getParameter("operazione");

		
		
		ArrayList<String> s = Aggregation.lanciaGroup(bdo, annoA, annoDa, dbo2, listaAltriCampi, operazione);
		request.setAttribute("tabella", s);
	
		RequestDispatcher rd = request.getRequestDispatcher("aggregazione.jsp");
		rd.forward(request, response);


		//doGet(request, response);
	}

}
