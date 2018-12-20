class molecule //all in Hartree
{
	//from inputs
	public String name;
	public double e_gas;
	public double e_cosmo;
	public double e_smd;
	public double g_e_Eh;
	//from calculation
	public double g_cosmo;
	public double g_smd;
	public double delta_Gs_cosmo;
	public double delta_Gs_smd;

	//constructor
	public molecule(String inp_name, String inp_e_gas, String inp_e_cosmo, String inp_e_smd, String inp_g_e_Eh)
	{
		//inputs
		name = inp_name;
		e_gas = Double.parseDouble(inp_e_gas);
		e_cosmo = Double.parseDouble(inp_e_cosmo);
		e_smd = Double.parseDouble(inp_e_smd);
		g_e_Eh = Double.parseDouble(inp_g_e_Eh);
		//calculation
		g_cosmo = e_cosmo + g_e_Eh;
		g_smd = e_smd + g_e_Eh;
		delta_Gs_cosmo = g_cosmo - e_gas;
		delta_Gs_smd = g_smd - e_gas;
	}//end constructor

}//end class