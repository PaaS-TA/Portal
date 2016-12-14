package org.openpaas.paasta.portal.api.model;

/**
 * 
 * @author Harry Zhang
 *
 */
public class Quota extends Entity {

    private boolean nonBasicServicesAllowed = false;
    private int totalServices;
    private int totalRoutes;
    private int memoryLimit;

	public Quota(){
	}

    public Quota(Meta meta, String name, boolean nonBasicServicesAllowed,
				 int totalServices, int totalRoutes, int memoryLimit) {
        super(meta, name);
        this.totalServices=totalServices;
        this.totalRoutes=totalRoutes;
        this.memoryLimit=memoryLimit;
        this.nonBasicServicesAllowed = nonBasicServicesAllowed;

    }
    /**
     * Default value :"memory_limit":0,"total_routes":0,"total_services":0,"non_basic_services_allowed":false
     * 
     * @param meta
     * @param name
     */
    public Quota(Meta meta, String name){
    	super(meta, name);
    }

	public int getTotalServices() {
		return totalServices;
	}

	public void setTotalServices(int totalServices) {
		this.totalServices = totalServices;
	}

	public int getTotalRoutes() {
		return totalRoutes;
	}

	public void setTotalRoutes(int totalRoutes) {
		this.totalRoutes = totalRoutes;
	}

	public int getMemoryLimit() {
		return memoryLimit;
	}

	public void setMemoryLimit(int memoryLimit) {
		this.memoryLimit = memoryLimit;
	}

	public void setNonBasicServicesAllowed(boolean nonBasicServicesAllowed) {
		this.nonBasicServicesAllowed = nonBasicServicesAllowed;
	}

	 public boolean isNonBasicServicesAllowed() {
	        return nonBasicServicesAllowed;
	    }
    

}