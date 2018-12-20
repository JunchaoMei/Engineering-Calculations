import java.util.*;

class pKa
{
	//input parameters
	static String molecule_type = "Water4";
	static int high_charge = Integer.parseInt("+1");
	//real static variables
	static int low_charge = high_charge-1;
	static double R = 1.985877534/1000; //kcal/K/mol
	static double T = 298.15; //K
	static double H = -265.9; //kcal/mol
	static double Eh_kcal = 627.51; //1 Hartree = 627.51 kcal/mol
	static String[][] table;
	static String[][] out;
	static ArrayList<molecule> High = new ArrayList<molecule>();
	static ArrayList<molecule> Low = new ArrayList<molecule>();

	public static void loadData () throws Exception
	{
		String fileName = molecule_type + ".xls";
		table = TableIO.readTable(fileName);
	}//end loadData

	public static void initialize ()
	{
		int n = table.length;
		for (int i=1; i<n; i++)
		{
			if (Integer.parseInt(table[i][0].split("_")[1]) == high_charge)
			{
				molecule mole_high = new molecule(table[i][0],table[i][1],table[i][2],table[i][3],table[i][4]);
				High.add(mole_high);
			} else if (Integer.parseInt(table[i][0].split("_")[1]) == low_charge)
			{
				molecule mole_low = new molecule(table[i][0],table[i][1],table[i][2],table[i][3],table[i][4]);
				Low.add(mole_low);
			}//end if
		}//end for loop
	}//end initialize

	public static void output ()
	{
		int n_High = High.size();
		int n_Low = Low.size();
		int n_out = n_High*n_Low;

		out = new String[n_out][4];
		int k = 0;

		for (int i=0;i<n_High;i++)
		{
			for (int j=0;j<n_Low;j++)
			{
				out[k][0] = High.get(i).name;
				out[k][1] = Low.get(j).name;
				double g_high_cosmo = High.get(i).g_cosmo*Eh_kcal;
				double g_low_cosmo = Low.get(j).g_cosmo*Eh_kcal;
				double delta_g_cosmo = g_low_cosmo + H - g_high_cosmo;
				double pKa_cosmo = delta_g_cosmo/(2.303*R*T);
				out[k][2] = pKa_cosmo+"";
				double g_high_smd = High.get(i).g_smd*Eh_kcal;
				double g_low_smd = Low.get(j).g_smd*Eh_kcal;
				double delta_g_smd = g_low_smd + H - g_high_smd;
				double pKa_smd = delta_g_smd/(2.303*R*T);
				out[k][3] = pKa_smd+"";
				k++;
			}//end for loop j
		}//end for loop i
	}//end output

	public static void printTable (String[][] table)
	{
		for (int x = 0; x < table.length; x++)
		{
			for (int y = 0; y < table[x].length; y++)
				System.out.print(table[x][y] + "	");
			System.out.println();
		}//end for loop x
	}//end print2dArray

	public static void main (String[] args) throws Exception
	{
		loadData();
		initialize();
		output();
		printTable(out);
	}//end main
}//end class