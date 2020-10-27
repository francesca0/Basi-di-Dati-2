package gestione;

import java.util.ArrayList;

public class ChartItem {
	
	String range;
	
	ArrayList<Long> value;
	
	public ChartItem(){
		
	}

	public String toJSOBJ() {
		return "{range: \"" + range + "\", value:" + value + "}";
	}

	
}
